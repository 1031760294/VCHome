//
//  HelpViewController.m
//  VCHome
//
//  Created by adminsjp on 16/4/25.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "HelpViewController.h"
#import "UserFeedBackViewController.h"
#import "AboutUsViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)fankuiAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[[UserFeedBackViewController alloc]init] animated:YES];
}

- (IBAction)guanyuAtion:(UIButton *)sender forEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[[AboutUsViewController alloc]init] animated:YES];
}
@end
