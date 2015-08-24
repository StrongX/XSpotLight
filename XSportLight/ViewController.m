//
//  ViewController.m
//  XSportLight
//
//  Created by xlx on 15/8/22.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import "ViewController.h"
#import "XSportLight.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<XSportLightDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}
-(void)viewDidAppear:(BOOL)animated{

    
    XSportLight *SportLight = [[XSportLight alloc]init];
    SportLight.messageArray = @[
                                @"这是《简书》",
                                @"点这里撰写文章",
                                @"搜索文章",
                                @"这会是StrongX的下一节课内容"
                                ];
    SportLight.rectArray = @[
                             [NSValue valueWithCGRect:CGRectMake(0,0,0,0)],
                             [NSValue valueWithCGRect:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - 20, 50, 50)],
                             [NSValue valueWithCGRect:CGRectMake(SCREEN_WIDTH - 20, 42, 50, 50)],
                             [NSValue valueWithCGRect:CGRectMake(0,0,0,0)]
                             ];
    
    SportLight.delegate = self;
    [self presentViewController:SportLight animated:false completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)XSportLightClicked:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}

@end
