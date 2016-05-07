//
//  tipsView.m
//  MyAlertView
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 毕炜勇. All rights reserved.
//

#import "tipsView.h"

static UIButton *_cover;

@implementation tipsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(50, [UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.width - 100, 30);
        [self createSelf];
    }
    return self;
}

- (void)createSelf
{
    self.tipsLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    self.tipsLable.backgroundColor = [UIColor blackColor];
    self.tipsLable.layer.cornerRadius = 5.0;
    self.tipsLable.layer.masksToBounds = YES;
    self.tipsLable.alpha = 0.5;
    self.tipsLable.textColor = [UIColor whiteColor];
    self.tipsLable.textAlignment = NSTextAlignmentCenter;
    self.tipsLable.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.tipsLable];
}

#pragma mark - Animated Mthod
- (void)animatedIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
        
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(animatedOut) userInfo:nil repeats:NO];
    }];
}

- (void)animatedOut
{
    [UIView animateWithDuration:.35 animations:^{
        [self removeFromSuperview];
        [_cover removeFromSuperview];
        _cover = nil;
    }];
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication].windows lastObject];
    keywindow.windowLevel = UIWindowLevelNormal;
    
    // 遮盖
    UIButton *cover = [[UIButton alloc] init];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    cover.frame = [UIScreen mainScreen].bounds;
    _cover = cover;
    
    [keywindow addSubview:cover];
    [keywindow addSubview:self];
    
    [cover addTarget:self action:@selector(goIntoHiding) forControlEvents:UIControlEventTouchUpInside];
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self animatedIn];
}

- (void)goIntoHiding
{
    [self animatedOut];
}


@end
