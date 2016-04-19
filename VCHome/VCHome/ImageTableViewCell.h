//
//  ImageTableViewCell.h
//  VCHome
//
//  Created by adminsjp on 16/4/19.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dpm;
@property (weak, nonatomic) IBOutlet UILabel *rental;
@property (weak, nonatomic) IBOutlet UILabel *describe;

@end
