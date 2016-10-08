//
//  ViewController.m
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Tangxianhai. All rights reserved.
//

#import "ViewController.h"
#import "TXHRrettyRuler.h"

#define degreeTOradians(x) (M_PI * (x)/180)

@interface ViewController () <TXHRrettyRulerDelegate>

@end

@implementation ViewController {
    UILabel *showLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建一个显示的标签
    showLabel = [[UILabel alloc] init];
    showLabel.font = [UIFont systemFontOfSize:20.f];
    showLabel.text = @"当前刻度值:20";
    showLabel.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 20 * 2, 40);
    showLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:showLabel];
    
    // 2.创建 TXHRrettyRuler 对象 并设置代理对象
    TXHRrettyRuler *ruler = [[TXHRrettyRuler alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.height - 20 * 2, 140)];
    ruler.rulerDeletate = self;
    [ruler showRulerScrollViewWithCount:600 average:[NSNumber numberWithFloat:0.1] currentValue:16.5f smallMode:YES];
    ruler.transform = CGAffineTransformMakeRotation(degreeTOradians(-90));
    [self.view addSubview:ruler];
}

- (void)txhRrettyRuler:(TXHRulerScrollView *)rulerScrollView {
    showLabel.text = [NSString stringWithFormat:@"当前刻度值: %.1f",rulerScrollView.rulerValue];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com