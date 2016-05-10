//
//  CarDetailViewController.h
//  VCHome
//
//  Created by adminsjp on 16/4/22.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageTV;
@property (weak, nonatomic) IBOutlet UILabel *pingpai;
@property (weak, nonatomic) IBOutlet UILabel *peizhi;
@property (weak, nonatomic) IBOutlet UILabel *pailiang;
@property (weak, nonatomic) IBOutlet UILabel *zuowei;
@property (weak, nonatomic) IBOutlet UILabel *chepaihao;
@property (weak, nonatomic) IBOutlet UILabel *zujin;

@property (weak, nonatomic) IBOutlet UILabel *zuqi;
@property (weak, nonatomic) IBOutlet UILabel *fengge;
@property (weak, nonatomic) IBOutlet UILabel *miaoshu;
@property (weak, nonatomic) IBOutlet UILabel *weizhiLable;
- (IBAction)quedingAction:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)shoucangAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property(strong,nonatomic)PFObject *object;

@end
