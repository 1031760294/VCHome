//
//  ZiJiaViewController.m
//  VCHome
//
//  Created by adminsjp on 16/4/18.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "ZiJiaViewController.h"
#import "Banner.h"
@interface ZiJiaViewController ()<BannerDataSource,BannerDelegate>

@end

@implementation ZiJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    Banner *bv = [[Banner alloc]init];
    bv.frame = CGRectMake(0, 135, size.width, 208);
    bv.bannerDelegate = self;
    bv.dataSource = self;
    [bv startPlay];
    [self.view addSubview:bv];
    
    // Do any additional setup after loading the view.
    // 平时工作需要有个下拉菜单所以简单的封装了一个菜单功能很简单也没有优化可为大家做一个参考,以下是demo
    
    // 如果是有导航栏请清除自动适应设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *threeMenuTitleArray =  @[@"车型",@"价格",@"租期"];
    
    
    //  创建第一个菜单的first数据second数据
    NSArray *firstArrOne = [NSArray arrayWithObjects:@"奔驰",@"奥迪",@"大众", nil];
    
    
    NSArray *firstMenu = [NSArray arrayWithObject:firstArrOne];
    
    
    
    
    //  创建第二个菜单的first数据second数据
    NSArray *firstArrTwo = [NSArray arrayWithObjects:@"100-500",@"500-1000", nil];
    NSArray *secondArrTwo = @[@[@"200-300",@"300-400"],@[@"600-750",@"750-900"]];
    NSArray *secondMenu = [NSArray arrayWithObjects:firstArrTwo,secondArrTwo, nil];
    
    //  创建第三个菜单的first数据second数据
    NSArray *firstArrThree = [NSArray arrayWithObjects:@"自定义",@"一天", nil];
    NSArray *secondArrThree = @[@[@"一周",@"一个月"],@[@"半天",@"一天半"]];
    NSArray *threeMenu = [NSArray arrayWithObjects:firstArrThree,secondArrThree, nil];
    
    
    
    
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 108, 0, 0)];//  size已固定可以随便填已固定
    menu.caverAnimationTime = 0.2;//  增加了遮盖层动画时间设置 不设置默认是 0.15
    menu.menuTitleFont = 12;      //  设置menuTitle字体大小 默认不设置是  11
    menu.tableTitleFont = 11;     //  设置tableTitle字体大小 默认不设置是 10
    menu.delegate = self;         //  设置代理
    
    [self.view addSubview:menu];
    
    
    
    // 三组菜单调用方法
    [menu createThreeMenuTitleArray:threeMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu];
    
    
    
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

- (void)menuCellDidSelected:(NSInteger)MenuIndex andDetailIndex:(NSInteger)DetailIndex{
    NSLog(@"菜单数:%ld 子菜单数:%ld",MenuIndex,DetailIndex);
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
@end
