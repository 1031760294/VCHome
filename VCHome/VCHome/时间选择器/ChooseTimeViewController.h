//
//  ChooseTimeViewController.h
//  Choose
//
//  Created by Sunday on 16/5/6.
//  Copyright © 2016年 Sunday. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^chooseDate)(NSArray*goDate,NSArray*backDate);

/**
 *  时间选择器
 */

@interface ChooseTimeViewController : UIViewController

@property (nonatomic,copy) chooseDate selectedDate;

/**
 *  返回选中时间
 *
 *  @param listDate 时间
 */

- (void)backDate:(chooseDate)listDate;

@end
