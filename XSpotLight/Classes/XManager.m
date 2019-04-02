
#import "XManager.h"

@implementation XManager
@synthesize hintDelegate;


-(void)clear
{
    [_modalView removeFromSuperview];
    _modalView = nil;
}
-(UIView*)modalView
{
    return _modalView;
}
-(UIView *)presentModalMessage:(NSString*)message where:(UIView*)presentationPlace
{
    //incase we have many in a row
    if(_modalView!=nil)
        [self clear];
    
    if ([self.hintDelegate respondsToSelector:@selector(hintStateViewsToHint:)]) {
        NSArray *viewArray = [self.hintDelegate hintStateViewsToHint:self];
        if(viewArray!=nil)
            _modalView = [[XSpotView alloc] initWithFrame:presentationPlace.frame forViews:viewArray];
    }
    
    if ([self.hintDelegate respondsToSelector:@selector(hintStateRectsToHint:)]) {
        NSArray* rectArray = [self.hintDelegate hintStateRectsToHint:self];
        if (rectArray != nil)
            _modalView = [[XSpotView alloc] initWithFrame:presentationPlace.frame withRects:rectArray];
    }
    
    if (_modalView==nil)
        _modalView = [[XSpotView alloc] initWithFrame:presentationPlace.frame];
    
    [_modalView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
//    [presentationPlace addSubview:_modalView];
    
    UIView *v = nil;

    if(v==nil)//no custom subview
    {
        //label
        UIFont *ft = [UIFont fontWithName:@"Helvetica" size:17.0];
        CGSize sz =[message boundingRectWithSize:CGSizeMake(250, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:ft} context:nil].size;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(floorf(presentationPlace.center.x - sz.width/2),
                                                                   floorf(presentationPlace.center.y - sz.height/2),
                                                                   floorf(sz.width),
                                                                   floorf(sz.height +10
                                                                          ))];
        [label setTextColor:[UIColor whiteColor]];

       
        
        [label setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin
                                    | UIViewAutoresizingFlexibleRightMargin
                                    | UIViewAutoresizingFlexibleLeftMargin
                                    | UIViewAutoresizingFlexibleBottomMargin
                                    )];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:ft];
        [label setAdjustsFontSizeToFitWidth:true];
        [label setText:message];
        [label setNumberOfLines:0];
        [_modalView addSubview:label];
     }
    

    
    return _modalView;
}
#pragma mark ---------------------------------->>
#pragma mark -------------->>cleanup
- (void)dealloc {
    
}


@end
