//
//  XSpotLight.m
//  XSpotLight
//
//  Created by xlx on 15/8/22.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import "XSpotLight.h"
#import "XManager.h"

@interface XSpotLight ()<XSpotDelegate>


@property (nonatomic,  ) int index;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) XManager *modalState;

@end
@implementation XSpotLight
-(id)init{
    self = [super init];
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    return  self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    _index = 0;
    [self show];
}

#pragma mark ---------------------------------->>
#pragma mark -------------->>HInt Delegate

-(NSArray*)hintStateRectsToHint:(id)hintState
{
    NSArray* rectArray = nil;
    NSValue *value = _rectArray[_index];
    CGRect rect = value.CGRectValue;
    rectArray = [[NSArray alloc] initWithObjects:[NSValue valueWithCGRect:rect], nil];
    return rectArray;
}
-(void)hintStateWillClose:(id)hintState
{
    NSLog(@"i am about to close: %@",hintState);
}
-(void)hintStateDidClose:(id)hintState
{
    NSLog(@"i closed: %@",hintState);
}




-(void)show{
    _showView = [self.modalState presentModalMessage:_messageArray[_index] where:self.view];
    [self.view addSubview:_showView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [_showView addGestureRecognizer:tap];
}
- (void)tap{
    _index++;
    [_delegate XSpotLightClicked:_index];
    if (_index >= _messageArray.count) {
        [self dismissViewControllerAnimated:false completion:^{
            
        }];
    }else{
        [_showView removeFromSuperview];
        [self show];
    }
}

#pragma mark - getter & setter

-(XManager *)modalState{
    if (!_modalState) {
        _modalState = [[XManager alloc] init];
        [_modalState setHintDelegate:self];
    }
    return _modalState;
}

@end
