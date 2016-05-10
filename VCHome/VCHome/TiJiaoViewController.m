//
//  TiJiaoViewController.m
//  VCHome
//
//  Created by adminsjp on 16/5/10.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "TiJiaoViewController.h"

@interface TiJiaoViewController ()

@end

@implementation TiJiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写身份信息";
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
//电话号码
- (BOOL)checkTel:(NSString *)mobileNumbel

{
    /**
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    
    
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        NSLog(@"手机号验证可用");
        return YES;
    }
    //    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    // [alert show];
    //[Utilities popUpAlertViewWithMsg:@"请输入正确的手机号码" andTitle:nil onView:self];
    return NO;
    
    
}
-(BOOL)validateEmail:(NSString *)email
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if( [emailTest evaluateWithObject:email]){
        
        NSLog(@"恭喜！您输入的邮箱验证合法");
        return YES;
        
    }else{
        
        //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的邮箱" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        //[Utilities popUpAlertViewWithMsg:@"请输入正确的邮箱" andTitle:nil onView:self];
        
        return NO;
    }
    return NO;
    
}
- (BOOL)checkIdentityCardNo:(NSString*)cardNo

{
    
    if (cardNo.length != 18) {
        //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起!省份证的位数不够或过多" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        //[Utilities popUpAlertViewWithMsg:@"对不起!省份证的位数不够或过多" andTitle:nil onView:self];
        
        return  NO;
        
    }
    
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    
    
    int val;
    
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    
    if (!isNum) {
        NSLog(@"输入的省份证号码不对");
        return NO;
    }
    
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
        
    }
    
    
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        NSLog(@"验证省份证号码可用");
        return YES;
        
    }
    //    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"省份证份证号码错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //
    //    [alert show];
    [Utilities popUpAlertViewWithMsg:@"身份证份证号码错误" andTitle:nil onView:self];
    
    return  NO;
    
}




- (IBAction)tijiaoAction:(UIButton *)sender forEvent:(UIEvent *)event {
    
    NSString *error = @"";
    if (_phoneNumber.text.length != 0 || _emailNumber.text.length != 0 ||_personalNumber.text.length != 0) {
        if ([self checkTel:_phoneNumber.text] && [self validateEmail:_emailNumber.text] && [self checkIdentityCardNo:_personalNumber.text]){
            NSLog(@"通过验证");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"您的身份信息填写成功，订单已提交，祝您旅途愉快！" preferredStyle:UIAlertControllerStyleAlert];
//            [Utilities popUpAlertViewWithMsg:@"您的身份信息填写成功，订单已提交，祝您旅途愉快！" andTitle:nil onView:self];
            UIAlertAction *confim = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //返回上一页
//                [self.navigationController popViewControllerAnimated:true];
                //返回首页
                [self.navigationController popToRootViewControllerAnimated:true];
            }];
            [alert addAction:confim];
            [self presentViewController:alert animated:true completion:nil];
        }else {
            if (![self checkTel:_phoneNumber.text]) error = [NSString stringWithFormat:@"%@%@",error,@"手机号 "];
            if (![self validateEmail:_emailNumber.text]) error = [NSString stringWithFormat:@"%@%@",error,@"邮箱 "];
            if (![self checkIdentityCardNo:_personalNumber.text]) error = [NSString stringWithFormat:@"%@%@",error,@"身份证号 "];
            
            error = [NSString stringWithFormat:@"%@%@%@",@"你所输入的",error,@"格式有误"];
            [Utilities popUpAlertViewWithMsg:error andTitle:nil onView:self];
        }
    }else {
        NSLog(@"不能为空");
    }
    
    
}
    

- (IBAction)fenduan:(UISegmentedControl *)sender forEvent:(UIEvent *)event {
    NSLog(@"23333333");
    if (sender.selectedSegmentIndex == 0){
        
        _lable.text = @"送车上门";
    } else {
        _lable.text = @"自行取车";
            }
}
//按return收回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}

@end
