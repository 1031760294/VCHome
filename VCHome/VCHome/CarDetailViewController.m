//
//  CarDetailViewController.m
//  VCHome
//
//  Created by adminsjp on 16/4/22.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "CarDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ChooseTimeViewController.h"
@interface CarDetailViewController ()
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@property(strong,nonatomic)NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

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
    _miaoshu.text =[NSString stringWithFormat:@"车主描述：%@",_object[@"describe"]];
    PFFile *photoFile = _object[@"photos"];
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [_imageTV sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"photos"]];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)showPick:(id)sender
{
    ChooseTimeViewController * vc =[ChooseTimeViewController new];
    
    __weak typeof(self)weekSelf = self;
    
    [vc backDate:^(NSArray *goDate, NSArray *backDate) {
        
        //        weekSelf.dataLabel.text = [NSString stringWithFormat:@"%@ : %@",[goDate componentsJoinedByString:@"-"],[backDate componentsJoinedByString:@"-"]];
        weekSelf.dataLabel.text = [NSString stringWithFormat:@"租车日期:%@",[goDate componentsJoinedByString:@"-"]];
        weekSelf.dateLabel.text = [NSString stringWithFormat:@"还车日期:%@",[backDate componentsJoinedByString:@"-"]];
    }];
    
    
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{
        
        
    }];


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
