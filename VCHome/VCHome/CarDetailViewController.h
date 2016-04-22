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


@property(strong,nonatomic)PFObject *object;

@end
