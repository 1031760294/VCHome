//
//  TimerCollectionReusableView.h
//  Choose
//
//  Created by Sunday on 16/5/7.
//  Copyright © 2016年 Sunday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;


- (void)updateTimer:(NSArray*)array;

@end
