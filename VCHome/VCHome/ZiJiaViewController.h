//
//  ZiJiaViewController.h
//  VCHome
//
//  Created by adminsjp on 16/4/18.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZiJiaViewController : UIViewController
@property (weak ,nonatomic) IBOutlet UITableView *tableView;
- (IBAction)menuAction:(UIButton *)sender forEvent:(UIEvent *)event;

@property (strong, nonatomic) IBOutlet UILabel *citylable;

@property(nonatomic, strong)NSString *cityName;
- (IBAction)shareAction:(UIBarButtonItem *)sender;

@end
