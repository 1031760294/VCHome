//
//  CarDetailViewController.m
//  VCHome
//
//  Created by adminsjp on 16/4/22.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "CarDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface CarDetailViewController ()
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@property(strong,nonatomic)NSDictionary *dict;

@end

@implementation CarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objectsForShow = [[NSMutableArray alloc]init];
    _dict = [NSDictionary new];
    NSLog(@"sss = %@",_object);
    _pingpai.text = _object[@"brand"];
    
        //_pingpai.text=_objectsForShow[0][@"brand"];
    //NSLog(@"fasdjifgifidsu = %@",_objectsForShow[0]);
    //_pingpai.text = _dict[@"brand"];
    //NSLog(@"sadsds = %@",_dict[@"brand"]);
   
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




@end
