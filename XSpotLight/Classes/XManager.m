
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
    
    if ([self.hintDelegate respondsToSelector:@selector(hintStateRectsToHint:)]) {
        NSArray* rectArray = [self.hintDelegate hintStateRectsToHint:self];
        if (rectArray != nil)
            _modalView = [[XSpotView alloc] initWithFrame:presentationPlace.bounds withRects:rectArray];
    }
    
    if (_modalView==nil)
        _modalView = [[XSpotView alloc] initWithFrame:presentationPlace.bounds];
    
   
        
    [self createTagLabelWithMessage:message];

    
    return _modalView;
}

-(void)createTagLabelWithMessage:(NSString *)message{
    //label
    CGFloat offSet = 20;
    UIFont *ft = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize sz =[message boundingRectWithSize:CGSizeMake(CGRectGetWidth(_modalView.frame)-offSet*2, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:ft} context:nil].size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(_modalView.frame)-offSet*2,sz.height +10)];
    label.center = _modalView.center;
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:ft];
    [label setAdjustsFontSizeToFitWidth:true];
    [label setText:message];
    [label setNumberOfLines:0];
    [_modalView addSubview:label];
}

#pragma mark ---------------------------------->>
#pragma mark -------------->>cleanup
- (void)dealloc {
    
}


@end
