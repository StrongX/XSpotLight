//
//  XSportLight.h
//  XSportLight
//
//  Created by xlx on 15/8/22.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMHint.h"

@interface XSportLight : UIViewController<EMHintDelegate>
{
    EMHint *modalState;
}

@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic,       ) NSArray *rectArray;


@end
