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
    _pingpai.text = [NSString stringWithFormat:@"品牌:%@",_object[@"brand"]];
    _peizhi.text = [NSString stringWithFormat:@"配置:%@",_object[@"autoConfiguration"]];
    _pailiang.text = [NSString stringWithFormat:@"排量:%@",_object[@"displacement"]];
    _zuowei.text = [NSString stringWithFormat:@"座位:%@个人",_object[@"seatNumber"]];
    _zujin.text = [NSString stringWithFormat:@"租金:%@",_object[@"carRental"]];
    _chepaihao.text = [NSString stringWithFormat:@"车牌:%@",_object[@"carNum"]];
    _fengge.text = [NSString stringWithFormat:@"风格:%@",_object[@"gearCategory"]];
    _zuqi.text = [NSString stringWithFormat:@"租期:%@",_object[@"lease"]] ;
    PFFile *photoFile = _object[@"photos"];
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [_imageTV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"photos"]];

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
