//
//  ViewController.h
//  VCHome
//
//  Created by adminsjp on 16/4/16.
//  Copyright © 2016年 Cool. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReturnCityName)(NSString *cityname);
@interface ViewController : UIViewController
@property (nonatomic, copy) ReturnCityName returnBlock;

- (void)returnText:(ReturnCityName)block;

@end

