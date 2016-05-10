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
#import "TiJiaoViewController.h"
#import "SignInViewController.h"
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
    _weizhiLable.text = [NSString stringWithFormat:@"%@",_object[@"city"]];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}





- (IBAction)quedingAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
    
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"currentUser = %@",currentUser);
    if (currentUser == nil) {
        NSLog(@"date = %@",_dataLabel.text);
        if (_dateLabel.text.length == 0 || _dataLabel.text.length==0) {
            [Utilities popUpAlertViewWithMsg:@"请选择日期" andTitle:nil onView:self];
            return;
        }
       NSString *msg = [NSString stringWithFormat:@"您当前未登录，是否立即前往"];
    
       UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
       
        SignInViewController *alert = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Denglu"];
        [self presentViewController:alert animated:YES completion:nil];
       }];
      UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
       [alertView addAction:confirmAction];
       [alertView addAction:cancelAction];
       [self presentViewController:alertView animated:YES completion:nil];
    } else {

    TiJiaoViewController *data = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Tijiao"];
    [self.navigationController pushViewController:data animated:YES];
    }
}
- (IBAction)shoucangAction:(UIButton *)sender forEvent:(UIEvent *)event {
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"currentUser = %@", currentUser);
    if (currentUser) {
        PFObject *obj = [PFObject objectWithClassName:@"Collection"];
        PFUser *user = [PFUser currentUser];
        obj[@"user"]=user;
        obj[@"xiangqing"]=_object;

        UIActivityIndicatorView *avi =[Utilities getCoverOnView:self.view];
        self.navigationController.view.userInteractionEnabled = NO;
        
        [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [avi stopAnimating];
            self.navigationController.view.userInteractionEnabled =YES;
            
            if (succeeded) {
                
                
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"添加收藏成功！" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
                
                [alertView addAction:ok];
                
                [self presentViewController:alertView animated:YES completion:nil];
                
            }else {
                NSLog(@"Error: %@",error.description);
                [Utilities popUpAlertViewWithMsg:@"网络繁忙，稍后再试" andTitle:nil onView:self];
                
                
            }
            
        }];
        
    }else{
        
        NSLog(@"当前用户没登录");
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"当前未登录，是否前往登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ConfirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            UINavigationController *tabVC = [Utilities getStoryboardInstance:@"Main" byIdentity:@"Denglu"];
            [self presentViewController:tabVC animated:YES completion:nil];
            
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertView addAction:ConfirmAction];
        [alertView addAction:cancelAction];
        
        [self presentViewController:alertView animated:YES completion:nil];
        
        
    }

    
    }

@end
