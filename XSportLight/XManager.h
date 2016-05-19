
#import <Foundation/Foundation.h>
#import "XSpotView.h"

typedef enum
{
    XSpotShapeTypeRound,
    XSpotShapeTypeRectangle//TODO
}XSpotShapeType;

@protocol XSpotDelegate <NSObject>

@optional

-(BOOL)hintStateHasDefaultTapGestureRecognizer:(id)hintState ;



/*
 // return an array of UIView where spotlights should shine     
 */
-(NSArray*)hintStateViewsToHint:(id)hintState;

/*
 // the default hint space is a label with white helvetica text dynamically centered,
 // one can return a custom view here to override that label
 */
-(UIView*)hintStateViewForDialog:(id)hintState;

/*
 // return an array of rects (NSValue objs) for where spotlights should shine.
 // convenient if UIView array is not an option
 */
-(NSArray*)hintStateRectsToHint:(id)hintState;

/*
 // return NO, if you plan to daisy chain hints, or do someother action
 // return YES, to fad out modal hint view
 */
-(BOOL) hintStateShouldCloseIfPermitted:(id)hintState ;

/*
 // called just before the close (fade) of a modal state view     
 */
-(void) hintStateWillClose:(id)hintState ;

/*
 // called immediately after the modal hint view has faded to zero alpha and is removed     
 */
-(void) hintStateDidClose:(id)hintState ;

@end

@interface XManager : NSObject
{
    XSpotView *_modalView;//our transparent hint window with lablel and spotlight
}
@property (nonatomic,assign) id<XSpotDelegate> hintDelegate;

-(UIView*)modalView; // accessor to the modal view (use spareingly)
-(void)clear;//instant removal of modal view

/*
 //initiates the modal hint view 
 //default is a spotlight effect on the UIView or Rect returned from one of the protocol methods
 // message is the message in the label
 // where is the view onto which the modal will overlay
 */
-(UIView *)presentModalMessage:(NSString*)message where:(UIView*)presentationPlace;
@end
