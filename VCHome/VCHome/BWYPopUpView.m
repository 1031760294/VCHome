//
//  BWYPopUpView.m
//  MyAlertView
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 毕炜勇. All rights reserved.
//

#define K_VIEW_WIDTH  self.bounds.size.width
#define K_VIEW_HEIGHT  self.bounds.size.height
#define CREATEColor(r, g, b, d) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:d]

#import "BWYPopUpView.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

static UIButton *_cover;

@implementation BWYPopUpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(100, 100, 300, 170);
        [self placementCustomViewsInSelf];
    }
    return self;
}

- (void)placementCustomViewsInSelf
{
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 10.0;
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = TRUE;
    self.layer.masksToBounds = YES;
    
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_VIEW_WIDTH, 44)];
    self.titleLable.backgroundColor = [UIColor whiteColor];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.textColor = [UIColor blueColor];
    self.titleLable.font = [UIFont systemFontOfSize:16];
    self.titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleLable.numberOfLines = 0;
    [self addSubview:self.titleLable];
    
    VerySatisfiedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    VerySatisfiedButton.backgroundColor = [UIColor whiteColor];
    VerySatisfiedButton.frame = CGRectMake(0, self.titleLable.frame.origin.y + 45, K_VIEW_WIDTH/3.0, 70);
    [VerySatisfiedButton setImage:[UIImage imageNamed:@"BWYPopNomal.png"] forState:UIControlStateNormal];
    [VerySatisfiedButton setImage:[UIImage imageNamed:@"BWYPopSelect.png"] forState:UIControlStateSelected];
    [VerySatisfiedButton setTitle:@"非常满意" forState:UIControlStateNormal];
    [VerySatisfiedButton setTitle:@"非常满意" forState:UIControlStateSelected];
    VerySatisfiedButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [VerySatisfiedButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [VerySatisfiedButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [VerySatisfiedButton setTintColor:[UIColor whiteColor]];
    [VerySatisfiedButton setTitleEdgeInsets:UIEdgeInsetsMake(10, - 40, 30, 0)];
    [VerySatisfiedButton setImageEdgeInsets:UIEdgeInsetsMake(40, (K_VIEW_WIDTH/3.0 - 20)/2.0, 10, (K_VIEW_WIDTH/3.0 - 20)/2.0)];
    VerySatisfiedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    VerySatisfiedButton.selected = NO;
    VerySatisfiedButton.tag = 118;
    [VerySatisfiedButton addTarget:self action:@selector(ChooseTheSatisfaction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:VerySatisfiedButton];
    
    SatisfiedButton = [UIButton buttonWithType:UIButtonTypeCustom];
     SatisfiedButton.backgroundColor = [UIColor whiteColor];
    SatisfiedButton.frame = CGRectMake(K_VIEW_WIDTH/3.0, VerySatisfiedButton.frame.origin.y, K_VIEW_WIDTH/3.0, 70);
    [SatisfiedButton setImage:[UIImage imageNamed:@"BWYPopNomal.png"] forState:UIControlStateNormal];
    [SatisfiedButton setImage:[UIImage imageNamed:@"BWYPopSelect.png"] forState:UIControlStateSelected];
    [SatisfiedButton setTitle:@"满意" forState:UIControlStateNormal];
    [SatisfiedButton setTitle:@"满意" forState:UIControlStateSelected];
    SatisfiedButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [SatisfiedButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [SatisfiedButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [SatisfiedButton setTintColor:[UIColor whiteColor]];
    [SatisfiedButton setTitleEdgeInsets:UIEdgeInsetsMake(10, - 35, 30, 0)];
    [SatisfiedButton setImageEdgeInsets:UIEdgeInsetsMake(40, (K_VIEW_WIDTH/3.0 - 20)/2.0, 10, (K_VIEW_WIDTH/3.0 - 20)/2.0)];
    SatisfiedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    SatisfiedButton.selected = NO;
    SatisfiedButton.tag = 119;
    [SatisfiedButton addTarget:self action:@selector(ChooseTheSatisfaction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:SatisfiedButton];
    
    NoSatisfiedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NoSatisfiedButton.backgroundColor = [UIColor whiteColor];
    NoSatisfiedButton.frame = CGRectMake(K_VIEW_WIDTH/3.0 * 2, VerySatisfiedButton.frame.origin.y, K_VIEW_WIDTH/3.0, 70);
    [NoSatisfiedButton setImage:[UIImage imageNamed:@"BWYPopNomal.png"] forState:UIControlStateNormal];
    [NoSatisfiedButton setImage:[UIImage imageNamed:@"BWYPopSelect.png"] forState:UIControlStateSelected];
    [NoSatisfiedButton setTitle:@"不满意" forState:UIControlStateNormal];
    [NoSatisfiedButton setTitle:@"不满意" forState:UIControlStateSelected];
    NoSatisfiedButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [NoSatisfiedButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [NoSatisfiedButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [NoSatisfiedButton setTintColor:[UIColor whiteColor]];
    [NoSatisfiedButton setTitleEdgeInsets:UIEdgeInsetsMake(10, - 40, 30, 0)];
    [NoSatisfiedButton setImageEdgeInsets:UIEdgeInsetsMake(40, (K_VIEW_WIDTH/3.0 - 20)/2.0, 10, (K_VIEW_WIDTH/3.0 - 20)/2.0)];
    NoSatisfiedButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    NoSatisfiedButton.selected = NO;
    NoSatisfiedButton.tag = 120;
    [NoSatisfiedButton addTarget:self action:@selector(ChooseTheSatisfaction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:NoSatisfiedButton];
    
    UILabel * NoLineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, NoSatisfiedButton.frame.origin.y + NoSatisfiedButton.frame.size.height + 10, K_VIEW_WIDTH, 1)];
    NoLineLable.backgroundColor = CREATEColor(227, 227, 227, 1.0);
    [self addSubview:NoLineLable];
    
    [self createButton];
}

- (void)createButton
{
    CGRect doneBtn = CGRectMake(0, self.bounds.size.height - 44, (self.bounds.size.width / 2.0f - 0.5) * 2, 44);
    UIButton *doneButton = [[UIButton alloc] initWithFrame:doneBtn];
    doneButton.backgroundColor = [UIColor whiteColor];
    [doneButton setTitle:@"确定" forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
    [doneButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.determineButton = doneButton;
    [self.determineButton addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.determineButton];
}

//按钮点击事件
- (void)ChooseTheSatisfaction:(UIButton *)button
{
    if (button.tag == 118) {
        VerySatisfiedButton.selected = YES;
        SatisfiedButton.selected = NO;
        NoSatisfiedButton.selected = NO;
        index = 1;
    }else if (button.tag == 119)
    {
        VerySatisfiedButton.selected = NO;
        SatisfiedButton.selected = YES;
        NoSatisfiedButton.selected = NO;
        index = 2;
    }else if (button.tag == 120)
    {
        VerySatisfiedButton.selected = NO;
        SatisfiedButton.selected = NO;
        NoSatisfiedButton.selected = YES;
        index = 3;
    }
}

- (void)buttonWasPressed:(UIButton *)button
{
    if (index != 0) {
        [self.deleget buttonClickIndex:index];
        [self animatedOut];  
    }
}

#pragma mark - Animated Mthod
- (void)animatedIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
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
    cover.alpha = 0.4;
    cover.frame = [UIScreen mainScreen].bounds;
    _cover = cover;
    
    [keywindow addSubview:cover];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self animatedIn];
}

- (void)goIntoHiding
{
    [self animatedOut];
}

@end
