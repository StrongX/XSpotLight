
# XSpotLight

[![CI Status](https://img.shields.io/travis/StrongX/XSpotLight.svg?style=flat)](https://travis-ci.org/StrongX/XSpotLight)
[![Version](https://img.shields.io/cocoapods/v/XSpotLight.svg?style=flat)](https://cocoapods.org/pods/XSpotLight)
[![License](https://img.shields.io/cocoapods/l/XSpotLight.svg?style=flat)](https://cocoapods.org/pods/XSpotLight)
[![Platform](https://img.shields.io/cocoapods/p/XSpotLight.svg?style=flat)](https://cocoapods.org/pods/XSpotLight)

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

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

XSpotLight is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XSpotLight'
```

## Author

StrongX, strongxlx@gmail.com

## License

XSpotLight is available under the MIT license. See the LICENSE file for more info.
