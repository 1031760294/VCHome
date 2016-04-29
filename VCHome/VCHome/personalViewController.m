//
//  personalViewController.m
//  VCHome
//
//  Created by adminsjp on 16/4/26.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import "personalViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "LeftViewController.h"

@interface personalViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    BOOL picked;
}

@property (strong,nonatomic) UIImagePickerController *imagePC;
@end

@implementation personalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imagerview.userInteractionEnabled = YES;
    picked = NO;
    [self uiConfiguration];
    [self reloadInputViews];
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
-(void)uiConfiguration{
    PFUser *currentuser = [PFUser currentUser];
    PFFile *photo = currentuser[@"headPortrait"];
    NSString *photoURLStr = photo.url;
    NSURL *photoURL = [NSURL URLWithString:photoURLStr];
    //异步加载和缓存
    [_imagerview sd_setImageWithURL:photoURL placeholderImage:[UIImage imageNamed:@"Image-3"]];
    
    NSString *nick = currentuser[@"nickname"];
    NSLog(@"nick = %@",nick);
    _nicknameTF.text = nick;
    NSString *gender = currentuser[@"gender"];
    _genderTF.text = gender;
    NSString *email = currentuser[@"email"];
    _emailTF.text = email;
}
-(void)pickImage:(UIImagePickerControllerSourceType )sourceType{
    NSLog(@"照片被按了");
    //判断当前选择的图片选择器控制器类型是否可用
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        //神奇的nil
        _imagePC =nil;
        //初始化一个图片选择器对象
        _imagePC = [[UIImagePickerController alloc]init];
        //签协议
        _imagePC.delegate = self;
        //设置图片选择器控制器类型
        _imagePC.sourceType = sourceType;
        //设置选中的媒体文件是否可以被编辑
        _imagePC.allowsEditing = YES;
        //设置可以被选择的媒体文件的类型
        _imagePC.mediaTypes =@[(NSString *)kUTTypeImage];
        [self presentViewController:_imagePC animated:YES completion:nil];
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:sourceType ==UIImagePickerControllerSourceTypeCamera ? @"您当前的设备没有照相功能" : @"meixiangce"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertView addAction:confirmAction];
        [self presentViewController:alertView animated:YES completion:nil];
        
    }
    
}

- (IBAction)pickimage:(UITapGestureRecognizer *)sender {
    NSLog(@"头像");
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"照相" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pickImage:UIImagePickerControllerSourceTypeCamera];
        
    }];
    UIAlertAction *choosePhoto = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pickImage:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:takePhoto];
    [actionSheet addAction:choosePhoto];
    [actionSheet addAction:cancelAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
}



//当选择完媒体文件后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //根据这个键去拿到我们选中的已经编辑过的图片
    UIImage *image= info[UIImagePickerControllerEditedImage];
    if (image) {
        picked = YES;
        //将拿到的图片设置为图片视图的图片
        _imagerview.image = image;
    }
    //用model方式返回上一页
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)backAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
    

}
- (IBAction)confirmAction:(UIButton *)sender forEvent:(UIEvent *)event {
    UIImage *image = _imagerview.image;
    NSString *name = _nicknameTF.text;
    NSString *gender = _genderTF.text;
    NSString *email = _emailTF.text;
    
    if (name.length == 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入昵称" andTitle:nil onView:self];
    } else {
        PFUser *currentUser = [PFUser currentUser];
        NSLog(@"currentUser = %@",currentUser);
        currentUser[@"nickname"] = name;
        currentUser[@"gender"] = gender;
        currentUser[@"email"] = email;
        if (picked) {
            //将一个UIImage对象转换成png格式的数据流
            NSData *photoData = UIImagePNGRepresentation(image);
            PFFile *photoFile = [PFFile fileWithName:@"photo.png" data:photoData];
            currentUser[@"headPortrait"] = photoFile;
        }
        
        
        UIActivityIndicatorView *aiv = [Utilities getCoverOnView:self.view];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [aiv stopAnimating];
            if (succeeded) {
                [Utilities popUpAlertViewWithMsg:@"保存成功" andTitle:nil onView:self];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [Utilities popUpAlertViewWithMsg:@"网络繁忙，请稍后再试" andTitle:nil onView:self];
            }
        }];
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
