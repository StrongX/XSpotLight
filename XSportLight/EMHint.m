
#import "EMHint.h"

@implementation EMHint
@synthesize hintDelegate;

#pragma mark ---------------------------------->> 
#pragma mark -------------->>private
//-(void)_onTap:(UITapGestureRecognizer*)tap
//{
//    BOOL flag = YES;
//    if ([self.hintDelegate respondsToSelector:@selector(hintStateShouldCloseIfPermitted:)]) {
//        flag = [self.hintDelegate hintStateShouldCloseIfPermitted:self];
//    }
//    if(!flag)return;
//    if ([self.hintDelegate respondsToSelector:@selector(hintStateWillClose:)]) {
//        [self.hintDelegate hintStateWillClose:self];
//    }
//    
//    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseOut 
//                     animations:^(){
//                         [_modalView setAlpha:0.0];
//                     } 
//                     completion:^(BOOL finished){
//                         [_modalView removeFromSuperview];
//                         _modalView = nil;
//                         if ([self.hintDelegate respondsToSelector:@selector(hintStateDidClose:)])
//                         {
//                             [self.hintDelegate hintStateDidClose:self];
//                         }
//
//                     }];
//    
//}
//
//-(void)_addTap
//{
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_onTap:)];
//    [_modalView addGestureRecognizer:tap]; 
// }

#pragma mark ---------------------------------->> 
#pragma mark -------------->>PUBLIC
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
            _modalView = [[EMHintsView alloc] initWithFrame:presentationPlace.frame forViews:viewArray];
    }
    
    if ([self.hintDelegate respondsToSelector:@selector(hintStateRectsToHint:)]) {
        NSArray* rectArray = [self.hintDelegate hintStateRectsToHint:self];
        if (rectArray != nil)
            _modalView = [[EMHintsView alloc] initWithFrame:presentationPlace.frame withRects:rectArray];
    }
    
    if (_modalView==nil)
        _modalView = [[EMHintsView alloc] initWithFrame:presentationPlace.frame];
    
    [_modalView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
//    [presentationPlace addSubview:_modalView];
    
    UIView *v = nil;
//    if ([[self hintDelegate] respondsToSelector:@selector(hintStateViewForDialog:)]) {
//        v = [self.hintDelegate hintStateViewForDialog:self];
//        [_modalView addSubview:v];
//    }
    
    if(v==nil)//no custom subview
    {
        //label
        UIFont *ft = [UIFont fontWithName:@"Helvetica" size:17.0];
        CGSize sz = [message sizeWithFont:ft constrainedToSize:CGSizeMake(250, 1000)];
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
    
//    if ([[self hintDelegate] respondsToSelector:@selector(hintStateHasDefaultTapGestureRecognizer:)]) {
//        BOOL flag = [self.hintDelegate hintStateHasDefaultTapGestureRecognizer:self];
//        if (flag) {
//            [self _addTap];
//        }
//    }else
//    {
//        [self _addTap];
//    }
    
    return _modalView;
}
#pragma mark ---------------------------------->>
#pragma mark -------------->>cleanup
- (void)dealloc {
    
}


@end
