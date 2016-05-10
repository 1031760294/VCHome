//
//  shoucangViewController.m
//  VCHome
//
//  Created by adminsjp on 16/5/10.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "shoucangViewController.h"
#import "UIImageView+WebCache.h"
#import "shoucangTableViewCell.h"
@interface shoucangViewController ()
@property(strong,nonatomic) NSMutableArray *ShouCangForShow;
@end

@implementation shoucangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    _ShouCangForShow = [NSMutableArray new];
    _tableView.tableFooterView = [[UITableView alloc]init];
    _tableView.allowsMultipleSelectionDuringEditing=YES;
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
- (void)requestData {
    [_ShouCangForShow removeAllObjects];
    PFUser *currentUser = [PFUser currentUser];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user = %@", currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Collection" predicate:predicate];
    [query includeKey:@"Vehicle"];
    self.navigationController.view.userInteractionEnabled = NO;
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        self.navigationController.view.userInteractionEnabled = YES;
        [avi stopAnimating];
        if (!error) {
            NSLog(@"objects = %@",objects);
            if (objects.count == 0 ) {
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"您当前没有任何收藏哦～" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ConfirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }];
                
                
                [alertView addAction:ConfirmAction];
                
                
                [self presentViewController:alertView animated:YES completion:nil];
                
                
            }else {
                _ShouCangForShow = [NSMutableArray arrayWithArray:objects];
                [_tableView reloadData];
            }
            
            
            
            
            
        }else {
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ShouCangForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   shoucangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *obj = _ShouCangForShow[indexPath.row];
    NSString *pingpaiL = obj[@"brand"];
    NSString *pailiangL = obj[@"displacement"];
    NSString *zujinL = obj [@"carRental"];
    NSString *miaoshuL = obj [@"describe"];
    cell.pingpaiL.text = [NSString stringWithFormat:@"品牌:%@",pingpaiL];
    cell.pailiangL.text =[NSString stringWithFormat:@"排量:%@",pailiangL];
    cell.zujinL.text = [NSString stringWithFormat:@"日租:%@",zujinL];
    cell.miaoshuL.text =miaoshuL;
    //获取数据库中某个文件的网络路径1
    PFFile *photoFile = obj[@"photos"];
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [cell.imageL sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"photos"]];
    //    [StorageMgr ]
    
    return cell;


    }
@end
