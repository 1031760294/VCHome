//
//  BWYPopUpView.h
//  MyAlertView
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 毕炜勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZJAlertListViewBlock)();

@protocol BWYPopUpViewDelegete <NSObject>

- (void)buttonClickIndex:(int)index;

@end

@interface BWYPopUpView : UIView
{
    UIButton * VerySatisfiedButton;
    UIButton * SatisfiedButton;
    UIButton * NoSatisfiedButton;
    int index;
}
/***BWYPopUpView标题***/
@property (nonatomic,strong) UILabel * titleLable;
@property (nonatomic,assign)id<BWYPopUpViewDelegete>deleget;
@property (nonatomic,strong)UIButton * determineButton;
@property (nonatomic,strong)UIButton * cancelButton;

/***BWYPopUpView展示***/
- (void)show;

/***BWYPopUpView隐藏***/
- (void)goIntoHiding;

@end
