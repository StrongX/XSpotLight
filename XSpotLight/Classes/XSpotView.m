

#import "XSpotView.h"
#import <QuartzCore/QuartzCore.h>

#define BACKGROUND_ALPHA 0.70

@interface XSpotView()

// array positions of spotlights
@property (nonatomic, strong) NSMutableArray* positionArray;
// array radius of spotlights
@property (nonatomic, strong) NSMutableArray* radiusArray;
@end

@implementation XSpotView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // set background color
        [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:BACKGROUND_ALPHA]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withRects:(NSArray *)rectArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // add spotlight position and radius
        for (NSValue* theRectObj in rectArray)
        {
            CGRect theRect = [theRectObj CGRectValue];
            CGPoint pos = CGPointMake(theRect.origin.x, theRect.origin.y);
            CGFloat radius = theRect.size.width;
            [self.positionArray addObject:[NSValue valueWithCGPoint:pos]];
            [self.radiusArray addObject:[NSNumber numberWithFloat:radius]];
        }
        [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:BACKGROUND_ALPHA]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame forViews:(NSArray *)viewArray
{
    self = [super initWithFrame:frame];
    if (self) {
       
        // add spotlight position and radius
        for (UIView* theView in viewArray)
        {
            CGPoint pos = CGPointMake(theView.frame.origin.x + (theView.frame.size.width/2)
                                    , theView.frame.origin.y + (theView.frame.size.height/2)  );
            CGFloat radius = theView.frame.size.width;
            [self.positionArray addObject:[NSValue valueWithCGPoint:pos]];
            [self.radiusArray addObject:[NSNumber numberWithFloat:radius]];
        }
        
        [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:BACKGROUND_ALPHA]];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self _background:rect];
}
-(void)_background:(CGRect)rect
{
    // context for drawing
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGImageRef backgroundimage = CGBitmapContextCreateImage(context);
    CGContextClearRect(context, rect);
    //CGContextDrawImage(context, rect, backgroundimage); 
    
    // save state
    CGContextSaveGState(context);
    
    // flip the context (right-sideup)
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);     
    
    //colors/components/locations
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat black[4] = {0.0,0.0,0.0,BACKGROUND_ALPHA};
    CGFloat white[4] = {1.0,1.0,1.0,1.0};//clear
    
    CGFloat components[8] = {
        
        white[0],white[1],white[2],white[3],        
        black[0],black[1],black[2],black[3],
    };
    
    CGFloat colorLocations[2] = {0.25,0.5};
    
    // draw spotlights
    NSInteger spotlightCount = self.positionArray.count;
    for (int i=0; i<spotlightCount; ++i)
    {
        // center and radius of spotlight
        CGPoint c = [[self.positionArray objectAtIndex:i] CGPointValue];
        CGFloat radius = [[self.radiusArray objectAtIndex:i] floatValue];
        
        //draw the shape
        CGMutablePathRef path = CGPathCreateMutable();
        //
        //draw a rect around view
        
        CGPathAddRect(path, NULL, CGRectMake(c.x - radius, c.y -radius,100,300));
        CGPathAddLineToPoint(path, NULL, c.x + radius, c.y - radius*2);
        CGPathAddLineToPoint(path, NULL, c.x + radius, c.y + radius*2);
        CGPathAddLineToPoint(path, NULL, c.x - radius, c.y + radius*2);
        CGPathAddLineToPoint(path, NULL, c.x - radius, c.y);
        CGPathAddLineToPoint(path, NULL, c.x, c.y);
        /*
         
         //draw a rectangle like spotlight --- i'll get to this later
         CGPathMoveToPoint(path, NULL, c.x-radius, c.y-radius);
         CGPathAddLineToPoint(path, NULL, c.x, c.y-radius);
         CGPathAddArcToPoint(path, NULL, c.x+radius, c.y-radius, c.x+radius, c.y, radius);
         CGPathAddArcToPoint(path, NULL, c.x+radius, c.y +radius, c.x , c.y+radius, radius);
         CGPathAddArcToPoint(path, NULL, c.x -radius, c.y + radius, c.x-radius, c.y, radius);
         CGPathAddArcToPoint(path, NULL, c.x-radius, c.y - radius, c.x, c.y-radius, radius);
         CGContextAddPath(context, path);    
         CGContextClip(context);
         
         //fill with gradient
         CGContextDrawRadialGradient(context, gradientRef, c, 0.0f, c, _radius*2, 0);
         
         
         */
        CGContextSaveGState(context);
        
        CGContextAddPath(context, path);  
        CGPathRelease(path);
        CGContextClip(context);
        
        //add gradient
        //create the gradient Ref
        CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorspace, components, colorLocations, 2);
        CGContextDrawRadialGradient(context, gradientRef, c, 0.0f, c, radius*2, 0);
        CGGradientRelease(gradientRef);
        
        CGContextRestoreGState(context);
    }
    
    CGColorSpaceRelease(colorspace);
    CGContextRestoreGState(context);
    
    //convert drawing to image for masking
    CGImageRef maskImage = CGBitmapContextCreateImage(context);
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskImage), 
                                        CGImageGetHeight(maskImage), 
                                        CGImageGetBitsPerComponent(maskImage), 
                                        CGImageGetBitsPerPixel(maskImage), 
                                        CGImageGetBytesPerRow(maskImage), 
                                        CGImageGetDataProvider(maskImage), NULL, FALSE);
    
    
    //mask the background image
    CGImageRef masked = CGImageCreateWithMask(backgroundimage, mask);
    CGImageRelease(backgroundimage);
    //remove the spotlight gradient now that we have it as image
    CGContextClearRect(context, rect);
    
    //draw the transparent background with the mask
    CGContextDrawImage(context, rect, masked);
    
    CGImageRelease(maskImage);
    CGImageRelease(mask);
    CGImageRelease(masked);
}

#pragma mark - getter & setter
-(NSMutableArray *)positionArray{
    if (!_positionArray) {
        _positionArray = [@[] mutableCopy];
    }
    return _positionArray;
}

-(NSMutableArray *)radiusArray{
    if (!_radiusArray) {
        _radiusArray = [@[] mutableCopy];
    }
    return _radiusArray;
}

@end
