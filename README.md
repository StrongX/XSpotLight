# XSportLight

![image](https://github.com/StrongX/XSportLight/blob/master/10.gif)

```objc
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
    [self presentViewController:SportLight animated:false completion:^{
        
    }];
```
