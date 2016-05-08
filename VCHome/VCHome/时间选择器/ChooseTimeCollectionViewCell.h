//
//  ChooseTimeCollectionViewCell.h
//  Choose
//
//  Created by Sunday on 16/5/6.
//  Copyright © 2016年 Sunday. All rights reserved.
//

#define CYBColorGreen [UIColor colorWithRed:78/255.0 green:147/255.0 blue:232/255.0 alpha:1]
#define YJCorl(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>

@interface ChooseTimeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;


@property (nonatomic ,strong) NSArray *currentArray;


/**
 *  更新布局
 *
 *  @param number   cell代表时间
 *  @param judge    选择租车时间
 *  @param judge    选择还车时间
 *  @param newArray 还车时间
 */
- (void)updateDay:(NSArray*)number outDate:(NSArray*)outdateArray selected:(NSInteger)judge currentDate:(NSArray*)newArray;

@end
