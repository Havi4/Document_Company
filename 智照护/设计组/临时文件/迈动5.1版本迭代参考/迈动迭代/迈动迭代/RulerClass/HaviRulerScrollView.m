//
//  HaviRulerScrollView.m
//  迈动迭代
//
//  Created by Havi on 16/4/20.
//  Copyright © 2016年 Havi. All rights reserved.
//

#import "HaviRulerScrollView.h"

@implementation HaviRulerScrollView

- (void)setRulerValue:(CGFloat)rulerValue {
    _rulerValue = rulerValue;
}

- (void)drawRuler {
    
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 1.f;
    shapeLayer1.lineCap = kCALineCapButt;
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineWidth = 1.f;
    shapeLayer2.lineCap = kCALineCapButt;
    
    for (int i = 0; i <= self.rulerCount; i++) {
        UILabel *rule = [[UILabel alloc] init];
        rule.textColor = [UIColor blackColor];
        rule.text = [NSString stringWithFormat:@"%.0f",i * [self.rulerAverage floatValue]];
        CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font }];
        if (i % 10 == 0) {
            CGPathMoveToPoint(pathRef2, NULL, DISTANCETOPANDBOTTOM,DISTANCELEFTANDRIGHT + DISTANCEVALUE * i);
            CGPathAddLineToPoint(pathRef2, NULL,self.rulerWidth - DISTANCETOPANDBOTTOM - textSize.width,  DISTANCELEFTANDRIGHT + DISTANCEVALUE * i);
            rule.frame = CGRectMake(self.rulerWidth - DISTANCETOPANDBOTTOM - textSize.height, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i - textSize.width / 2, 0, 0);
            [rule sizeToFit];
            [self addSubview:rule];
        }
        else if (i % 5 == 0) {
            CGPathMoveToPoint(pathRef1, NULL,  DISTANCETOPANDBOTTOM + 10 ,DISTANCELEFTANDRIGHT + DISTANCEVALUE * i);
            CGPathAddLineToPoint(pathRef1, NULL, self.rulerWidth - DISTANCETOPANDBOTTOM - textSize.height - 10 ,DISTANCELEFTANDRIGHT + DISTANCEVALUE * i);
        }
        else
        {
            CGPathMoveToPoint(pathRef1, NULL, DISTANCETOPANDBOTTOM + 20 ,DISTANCELEFTANDRIGHT + DISTANCEVALUE * i );
            CGPathAddLineToPoint(pathRef1, NULL, self.rulerWidth - DISTANCETOPANDBOTTOM - textSize.height - 20, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i);
        }
    }
    
    shapeLayer1.path = pathRef1;
    shapeLayer2.path = pathRef2;
    
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
    
    self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);
    
    // 开启最小模式
    if (_mode) {
        UIEdgeInsets edge = UIEdgeInsetsMake(self.rulerHeight / 2.f - DISTANCELEFTANDRIGHT, 0, self.rulerHeight / 2.f - DISTANCELEFTANDRIGHT, 0);
        self.contentInset = edge;
        self.contentOffset = CGPointMake(0, DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerHeight + (self.rulerHeight / 2.f + DISTANCELEFTANDRIGHT));
    }
    else
    {
        self.contentOffset = CGPointMake(0, DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerHeight / 2.f + DISTANCELEFTANDRIGHT);
    }
    
    self.contentSize = CGSizeMake(self.rulerWidth, self.rulerCount * DISTANCEVALUE + DISTANCELEFTANDRIGHT * 2.f);
}

@end
