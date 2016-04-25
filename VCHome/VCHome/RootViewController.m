//
//  RootViewController.m
//  AddressInfo
//
//  Created by Alesary on 16/1/7.
//  Copyright © 2016年 Mr.Chen. All rights reserved.
//

#import "RootViewController.h"
#import "Public.h"
#import "ViewController.h"

@interface RootViewController ()

@end


@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"Welcome";
    self.navigationController.navigationBar.barTintColor=RGB(44, 166, 248);
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttr];

}

- (IBAction)Push:(UIButton *)sender {
    
    ViewController *vc=[[ViewController alloc]init];
    
    [vc returnText:^(NSString *cityname) {
        
        self.citylable.text=cityname;
    }];
    
    [self.navigationController pushViewController:vc animated:NO];
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

@end
