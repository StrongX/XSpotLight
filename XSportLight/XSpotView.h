
#import <UIKit/UIKit.h>

@interface XSpotView : UIView
{
    // array positions of spotlights
    NSMutableArray* _positionArray;
    // array radius of spotlights
    NSMutableArray* _radiusArray;
}

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame forViews:(NSArray*)viewArray;
- (id)initWithFrame:(CGRect)frame withRects:(NSArray*)rectArray;
@end
