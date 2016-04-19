//
//  ZiJiaViewController.m
//  VCHome
//
//  Created by adminsjp on 16/4/18.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "ZiJiaViewController.h"
#import "ImageTableViewCell.h"
#import "Banner.h"
#import "UIImageView+WebCache.h"
#import "CarDeatailViewController.h"
#import "KSGuideManager.h"
@interface ZiJiaViewController () <BannerDataSource,BannerDelegate,WJMenuDelegate>
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@property(strong,nonatomic)NSString *i;

@end

@implementation ZiJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    
    _objectsForShow = [NSMutableArray new];
    [self requestData];
    _tableView.tableFooterView = [[UITableView alloc]init];
   //滚动视图
    Banner *bv = [[Banner alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_W, 140)];
    bv.bannerDelegate = self;
    bv.dataSource = self;
    [_tableView.tableHeaderView addSubview:bv];
    [bv startPlay];
    
    // Do any additional setup after loading the view.
    // 平时工作需要有个下拉菜单所以简单的封装了一个菜单功能很简单也没有优化可为大家做一个参考,以下是demo
    
    // 如果是有导航栏请清除自动适应设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *threeMenuTitleArray =  @[@"车型",@"价格",@"租期"];
    
    
    //  创建第一个菜单的first数据second数据
    NSArray *firstArrOne = [NSArray arrayWithObjects:@"奔驰",@"奥迪",@"宝马",@"本田",@"比亚迪",@"东方标准",@"别克",@"丰田",@"福特",@"海马",@"吉利",@"雷克萨斯", nil];
    
    
    NSArray *firstMenu = [NSArray arrayWithObject:firstArrOne];
    
    
    
    
    //  创建第二个菜单的first数据second数据
    NSArray *firstArrTwo = [NSArray arrayWithObjects:@"100",@"200", @"300",@"400",@"500",@"600",@"700",nil];
    //NSArray *secondArrTwo = @[@[@"200-300",@"300-400"],@[@"600-750",@"750-900"]];
    NSArray *secondMenu = [NSArray arrayWithObjects:firstArrTwo, nil];
    
    //  创建第三个菜单的first数据second数据
    NSArray *firstArrThree = [NSArray arrayWithObjects:@"0.5天",@"1天",@"1.5半",@"2天",@"2.5天",@"3天",@"3.5天",@"4天", nil];
   // NSArray *secondArrThree = @[@[@"一周",@"一个月"],@[@"半天",@"一天半"]];
    NSArray *threeMenu = [NSArray arrayWithObjects:firstArrThree, nil];
    
    
    
    
    WJDropdownMenu *menu = [[WJDropdownMenu alloc] initWithFrame:CGRectMake(0, 64 + 44, UI_SCREEN_W, 44)];//  size已固定可以随便填已固定
    menu.caverAnimationTime = 0.2;//  增加了遮盖层动画时间设置 不设置默认是 0.15
    menu.menuTitleFont = 12;      //  设置menuTitle字体大小 默认不设置是  11
    menu.tableTitleFont = 11;     //  设置tableTitle字体大小 默认不设置是 10
    menu.delegate = self;         //  设置代理
    
    [self.view addSubview:menu];
    
    
    
    // 三组菜单调用方法
    [menu createThreeMenuTitleArray:threeMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu];
    
    
    //第一次进入的引导动画
    
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"12" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"13" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"14" ofType:@"jpg"]];
    [[KSGuideManager shared] showGuideViewWithImages:paths];
    

}

//  点击图片
- (void)bannerView:(Banner *)bannerView didSelectImageAtIndex:(NSUInteger)index
{
    
}
//  图片数量
- (NSUInteger)numberOfItemsInBanner:(Banner *)Banner
{
    return 4;
}

//  图片资源
- (UIImage *)bannerView:(Banner *)bannerView imageInIndex:(NSUInteger)index {
    NSArray *ary = @[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]];
    return ary[index];
}
//菜单栏

- (void)menuCellDidSelected:(NSInteger)MenuIndex andDetailIndex:(NSInteger)DetailIndex{
    NSLog(@"菜单数:%ld 子菜单数:%ld",MenuIndex,DetailIndex);
    if (MenuIndex==0&&DetailIndex==0) {
        _i=@"奔驰";
        [self request];
    }
    if (MenuIndex==1&&DetailIndex==0) {
        _i=@"奥迪";
        [self request];
    }
    if (MenuIndex ==2&&DetailIndex ==0) {
        _i=@"宝马";
        [self request];
    }
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
//每次页面出现后
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"EnableGesture" object:nil];
}
//每次页面消失后
- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DisableGesture" object:nil];
}



- (IBAction)menuAction:(UIBarButtonItem *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MenuSwitch" object:nil];
}
//数据请求
- (void)requestData {
    [_objectsForShow removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    //让导航条失去交互能力
    self.navigationController.view.userInteractionEnabled = NO;
    //在根视图上创建一朵菊花，并转动
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //查询语句
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //让导航条恢复交互能力
        self.navigationController.view.userInteractionEnabled = YES;
        //停止菊花动画
        [avi stopAnimating];
        if (!error) {
            _objectsForShow = [NSMutableArray arrayWithArray:objects];
            NSLog(@"objects = %@",_objectsForShow);
            [_tableView reloadData];
        }else{
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
    }];
}

//tableView  多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objectsForShow.count;
}
//tableView 的显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    PFObject *obj = _objectsForShow[indexPath.row];
    NSString *name = obj[@"brand"];
    NSString *dpm = obj[@"displacement"];
    NSString *randal = obj [@"carRental"];
    NSString *describe = obj [@"describe"];
    cell.name.text = name;
    cell.dpm.text =[NSString stringWithFormat:@"排量:%@",dpm];
    cell.rental.text = [NSString stringWithFormat:@"日租:%@",randal];
    cell.describe.text =describe;
    //获取数据库中某个文件的网络路径1
    PFFile *photoFile = obj[@"photos"];
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [cell.Image sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"photos"]];
    

    return cell;
    
}
-(void)request{
    [_objectsForShow removeAllObjects];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"brand = %@",_i];
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"predicate:predicate];
    
    //让导航条失去交互能力
    self.navigationController.view.userInteractionEnabled = NO;
    //在根视图上创建一朵菊花，并转动
    UIActivityIndicatorView *avi = [Utilities getCoverOnView:self.view];
    //查询语句
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //让导航条恢复交互能力
        self.navigationController.view.userInteractionEnabled = YES;
        //停止菊花动画
        [avi stopAnimating];
        if (!error) {
            _objectsForShow = [NSMutableArray arrayWithArray:objects];
            NSLog(@"objects = %@",_objectsForShow);
            [_tableView reloadData];
        }else{
            NSLog(@"Error: %@",error.userInfo);
            [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅通" andTitle:nil onView:self];
        }
    }];


}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"car"]) {
//        NSIndexPath *indexPath = _tableView.indexPathForSelectedRow;
//        //根据上诉行数，获取该行所对应的数据
//        PFObject *obj = _objectsForShow[indexPath.row];
//        
//        CarDeatailViewController  *cdVC = segue.destinationViewController;
//        cdVC.obj = obj;
//    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //按钮取消选中
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CarDeatailViewController *date = [Utilities getStoryboardInstance:@"Main" byIdentity:@"car"];
    [self.navigationController pushViewController:date animated:nil];
    
    
    
    
}

-(BOOL)textView:(UITableView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
    //捕捉到return按钮被按下这一事件（return键按钮被按下实际上在文本输入视图中执行换行：／n）
    if ([text isEqualToString:@"/n"]) {
        //重设键盘初始响应器
        [textView resignFirstResponder];
    }
    return YES;
}

//键盘以外收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}

@end
