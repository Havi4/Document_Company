//
//  ViewController.m
//  迈动迭代
//
//  Created by Havi on 16/4/20.
//  Copyright © 2016年 Havi. All rights reserved.
//

#import "ViewController.h"
#import "HaviRulerView.h"

@interface ViewController ()<HaviRulerDelegate>
{
    UILabel *a;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HaviRulerView *ruler = [[HaviRulerView alloc] initWithFrame:CGRectMake(20, 64, 140, self.view.frame.size.height-128)];
    ruler.rulerDeletate = self;
    [ruler showRulerScrollViewWithCount:600 average:[NSNumber numberWithFloat:0.1] currentValue:16.5f smallMode:YES];
    [self.view addSubview:ruler];
    a = [[UILabel alloc]initWithFrame:CGRectMake(170, 200, 200, 40)];
    [self.view addSubview:a];
}

- (void)rulerSelected:(HaviRulerScrollView *)rulerScrollView{
    NSLog(@"%@",[NSString stringWithFormat:@"当前刻度值: %.1f",rulerScrollView.rulerValue]);
    a.text = [NSString stringWithFormat:@"当前刻度值: %.1f",rulerScrollView.rulerValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
