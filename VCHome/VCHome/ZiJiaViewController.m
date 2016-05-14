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
#import "CarDetailViewController.h"
#import "KSGuideManager.h"
#import "Public.h"
#import "ViewController.h"
#import "ZYShareView.h"
@interface ZiJiaViewController () <BannerDataSource,BannerDelegate,WJMenuDelegate>{
    BOOL isLoading;
}
@property(strong,nonatomic)NSMutableArray *objectsForShow;
@property(strong,nonatomic)NSString *i;
@property(strong,nonatomic)NSString *j;
@property(strong,nonatomic)NSString *k;
@property(strong, nonatomic)NSString *objId;
@property (strong, nonatomic) UIActivityIndicatorView *aiv;

@end

@implementation ZiJiaViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title=@"Welcome";
    
    
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttr];
    

    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //定位
   
    
    _i = @"";
    _j = @"";
    _k = @"";
    
    
    
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
    
    NSArray *threeMenuTitleArray =  @[@"车型",@"价格",@"排量"];
    
    
    //  创建第一个菜单的first数据second数据
    NSArray *firstArrOne = [NSArray arrayWithObjects:@"全部",@"奥迪",@"宝马",@"奔驰",@"本田",@"比亚迪",@"别克",@"东方标致",@"丰田",@"福特",@"海马",@"吉利",@"雷克萨斯",@"陆风",@"MG",@"马自达",@"起亚",@"奇瑞",@"日产",@"荣威",@"三菱", nil];
    
    
    NSArray *firstMenu = [NSArray arrayWithObject:firstArrOne];
    
    
    
    
    //  创建第二个菜单的first数据second数据
    NSArray *firstArrTwo = [NSArray arrayWithObjects:@"全部",@"100",@"200", @"300",@"400",@"500",@"600",@"700",nil];
    //NSArray *secondArrTwo = @[@[@"200-300",@"300-400"],@[@"600-750",@"750-900"]];
    NSArray *secondMenu = [NSArray arrayWithObjects:firstArrTwo, nil];
    
    //  创建第三个菜单的first数据second数据
    NSArray *firstArrThree = [NSArray arrayWithObjects:@"全部",@"1.3L",@"1.4L", @"1.5L",@"1.6L",@"1.8L",@"2.0L",@"1.5T",@"1.6T",@"1.8T",@"2.0T", nil];
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
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"15" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"16" ofType:@"jpg"]];
    [paths addObject:[[NSBundle mainBundle] pathForResource:@"17" ofType:@"jpg"]];
    [[KSGuideManager shared] showGuideViewWithImages:paths];
    
    
//    //下拉刷新
//    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
//    rc.tag = 1001;
//    rc.tintColor = [UIColor darkGrayColor];
//    [rc addTarget:self action:@selector(canToRequestData) forControlEvents:UIControlEventValueChanged];
//    [_tableView addSubview:rc];


}
//- (void)refreshData {
//    
//    isLoading = NO;//刚来到页面进行数据初始化时将“是否正在加载数据”指针设为否
//    
//    //在根视图上创建一朵菊花，并转动
//    _aiv = [Utilities getCoverOnView:self.view];
//    [self canToRequestData];
//    
//    
//}
//
//-(void)canToRequestData{
//    //只有当加载任务不在进行时，我们才该同意一个新的加载任务
//    if (!isLoading ) {
//        //当开始执行下拉刷新（包括刚来到页面执行的第一次请求）时将“是否正在加载数据”指针设为是
//        
//        isLoading = YES;
//        
//        [self requestData];
//    }
//}

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

- (void)menuCellDidSelected:(NSInteger)MenuIndex andDetailIndex:(NSInteger)DetailIndex andTag:(NSInteger)BtnTag{
    NSLog(@"按钮号:%ld 菜单数:%ld 子菜单数:%ld",BtnTag,MenuIndex,DetailIndex);
    switch (BtnTag) {
        case 0:
            switch (MenuIndex) {
                case 1:
                    _i = @"奥迪";
                    break;
                case 2:
                    _i = @"宝马";
                    break;
                case 3:
                    _i = @"奔驰";
                    break;
                case 4:
                    _i = @"本田";
                    break;
                case 5:
                    _i = @"比亚迪";
                    break;
                case 6:
                    _i = @"别克";
                    break;
                case 7:
                    _i = @"东方标致";
                    break;
                case 8:
                    _i = @"丰田";
                    break;
                case 9:
                    _i = @"福特";
                    break;
                case 10:
                    _i = @"海马";
                    break;
                case 11:
                    _i = @"吉利";
                    break;
                case 12:
                    _i = @"雷克萨斯";
                    break;
                case 13:
                    _i = @"陆风";
                    break;
                case 14:
                    _i = @"MG";
                    break;
                case 15:
                    _i = @"马自达";
                    break;
                case 16:
                    _i = @"起亚";
                    break;
                case 17:
                    _i = @"奇瑞";
                    break;
                case 18:
                    _i = @"日产";
                    break;
                case 19:
                    _i = @"荣威";
                    break;
                case 20:
                    _i = @"三菱 ";
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (MenuIndex) {
                case 1:
                    _j = @"100";
                    break;
                case 2:
                    _j = @"200";
                    break;
                case 3:
                    _j = @"300";
                    break;
                case 4:
                    _j = @"400";
                    break;
                case 5:
                    _j = @"500";
                    break;
                case 6:
                    _j = @"600";
                    break;
                case 7:
                    _j = @"700";
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (MenuIndex) {
                case 1:
                    _k = @"1.3L";
                    break;
                case 2:
                    _k = @"1.4L";
                    break;
                case 3:
                    _k = @"1.5L";
                    break;
                case 4:
                    _k = @"1.6L";
                    break;
                case 5:
                    _k = @"1.8L";
                    break;
                case 6:
                    _k = @"2.0L";
                    break;
                case 7:
                    _k = @"1.5T";
                    break;
                case 8:
                    _k = @"1.6T";
                    break;
                case 9:
                    _k = @"1.8T";
                    break;
                case 10:
                    _k = @"2.0T";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    [self request];
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

- (IBAction)menuAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MenuSwitch" object:nil];
}


//- (IBAction)menuAction:(UIBarButtonItem *)sender {
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"MenuSwitch" object:nil];
//}
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
//        isLoading = NO;
//        //根据下标找到刷新器
//        UIRefreshControl *rc = (UIRefreshControl *)[_tableView viewWithTag:1001];
//        [rc endRefreshing];
        //让导航条恢复交互能力
        self.navigationController.view.userInteractionEnabled = YES;
        //停止菊花动画
        [avi stopAnimating];
        if (!error) {
            _objectsForShow = nil;
            _objectsForShow = [NSMutableArray arrayWithArray:objects];
            NSLog(@"objects = %@",_objectsForShow[0]);
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
    cell.name.text = [NSString stringWithFormat:@"品牌:%@",name];
    cell.dpm.text =[NSString stringWithFormat:@"排量:%@",dpm];
    cell.rental.text = [NSString stringWithFormat:@"日租:%@",randal];
    cell.describe.text =describe;
    //获取数据库中某个文件的网络路径1
    PFFile *photoFile = obj[@"photos"];
    NSString *photoURLStr = photoFile.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //结合SDWebImage通过图片路径来实现异步加载和缓存（本案中加载到一个图片视图上）
    [cell.Image sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"photos"]];
//    [StorageMgr ]

    return cell;
    
}

-(void)request{
    [_objectsForShow removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Vehicle"];
    if (![_i isEqualToString:@""]) {
        [query whereKey:@"brand" equalTo:_i];
    }
    if (![_j isEqualToString:@""]) {
        [query whereKey:@"carRental" equalTo:_j];
    }
    if (![_k isEqualToString:@""]) {
        [query whereKey:@"displacement" equalTo:_k];
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //按钮取消选中
    PFObject *object = _objectsForShow[indexPath.row];
//    NSLog(@"--->1%@",object.objectId);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CarDetailViewController *date = [Utilities getStoryboardInstance:@"Main" byIdentity:@"car"];
    
    date.object = object;
    [self.navigationController pushViewController:date animated:YES];
}

- (IBAction)Push:(UIButton *)sender {
    [_objectsForShow removeAllObjects];
    ViewController *vc=[[ViewController alloc]init];
    __weak ZiJiaViewController *weakSelf = self;
    [vc returnText:^(NSString *cityname) {
        
        self.citylable.text=cityname;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"city = %@",cityname];
        PFQuery *query = [PFQuery queryWithClassName:@"Vehicle" predicate:predicate];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            NSLog(@"-->%@",objects);
            _objectsForShow = [NSMutableArray arrayWithArray:objects];
            [weakSelf.tableView reloadData];
        }];
        
    }];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(BOOL)textView:(UITableView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
    //捕捉到return按钮被按下这一事件（return键按钮被按下实际上在文本输入视图中执行换行：／n）
    if ([text isEqualToString:@"/n"]) {
        //重设键盘初始响应器
        [textView resignFirstResponder];
    }
    return YES;
}
//分享
- (IBAction)shareAction:(UIBarButtonItem *)sender {
    __weak typeof(self) weakSelf = self;
    
    // 创建代表每个按钮的模型
    ZYShareItem *item0 = [ZYShareItem itemWithTitle:@"发送给朋友"
                                               icon:@"Image-11"
                                            handler:^{ [weakSelf itemAction:@"点击了发送给朋友"];
                                                [Utilities popUpAlertViewWithMsg:@"分享了给朋友" andTitle:nil onView:self];}];
    
    ZYShareItem *item1 = [ZYShareItem itemWithTitle:@"分享到朋友圈"
                                               icon:@"Image-15"
                                            handler:^{ [weakSelf itemAction:@"点击了分享到朋友圈"]; [Utilities popUpAlertViewWithMsg:@"分享了给朋友圈" andTitle:nil onView:self];}];
    
    ZYShareItem *item2 = [ZYShareItem itemWithTitle:@"收藏"
                                               icon:@"Image-12"
                                            handler:^{ [weakSelf itemAction:@"点击了收藏"];
                                                [Utilities popUpAlertViewWithMsg:@"收藏了" andTitle:nil onView:self];}];
    
    ZYShareItem *item3 = [ZYShareItem itemWithTitle:@"QQ空间"
                                               icon:@"Image-9"
                                            handler:^{ [weakSelf itemAction:@"点击了QQ空间"];
                                                [Utilities popUpAlertViewWithMsg:@"分享到了空间" andTitle:nil onView:self];}];
    
    ZYShareItem *item4 = [ZYShareItem itemWithTitle:@"QQ"
                                               icon:@"Image-14"
                                            handler:^{ [weakSelf itemAction:@"点击了QQ"];
                                                [Utilities popUpAlertViewWithMsg:@"分享了到QQ" andTitle:nil onView:self];}];
    
    ZYShareItem *item5 = [ZYShareItem itemWithTitle:@"Facebook"
                                               icon:@"Image-7"
                                            handler:^{ [weakSelf itemAction:@"点击了Facebook"]; }];
    
    ZYShareItem *item6 = [ZYShareItem itemWithTitle:@"查看公众号"
                                               icon:@"Image-13"
                                            handler:^{ [weakSelf itemAction:@"点击了查看公众号"]; }];
    
    ZYShareItem *item7 = [ZYShareItem itemWithTitle:@"复制链接"
                                               icon:@"Image-6"
                                            handler:^{ [weakSelf itemAction:@"点击了复制链接"];
                                                [Utilities popUpAlertViewWithMsg:@"复制了链接" andTitle:nil onView:self];}];
    
    ZYShareItem *item8 = [ZYShareItem itemWithTitle:@"调整字体"
                                               icon:@"Image-8"
                                            handler:^{ [weakSelf itemAction:@"点击了调整字体"]; }];
    
    ZYShareItem *item9 = [ZYShareItem itemWithTitle:@"刷新"
                                               icon:@"Image-10"
                                            handler:^{ [weakSelf itemAction:@"点击了刷新"];
                                                [Utilities popUpAlertViewWithMsg:@"刷新了" andTitle:nil onView:self];}];
    
    // 创建shareView
    ZYShareView *shareView = [ZYShareView shareViewWithShareItems:@[item0, item1, item2, item3, item4, item5]
                                                    functionItems:@[item6, item7, item8, item9]];
    // 弹出shareView
    [shareView show];
    
}
- (void)itemAction:(NSString *)title
{
    NSLog(@"%@", title);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    // 白色导航栏
    return UIStatusBarStyleLightContent;
}
//按return收回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//键盘以外收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}


@end
