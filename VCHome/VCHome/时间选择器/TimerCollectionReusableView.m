//
//  TimerCollectionReusableView.m
//  Choose
//
//  Created by Sunday on 16/5/7.
//  Copyright © 2016年 Sunday. All rights reserved.
//

#import "TimerCollectionReusableView.h"

@implementation TimerCollectionReusableView

- (void)updateTimer:(NSArray *)array
{
    self.timerLabel.text = [NSString stringWithFormat:@"%@年%@月",array[0],array[1]];

}

- (void)awakeFromNib {
    // Initialization code
}

@end
