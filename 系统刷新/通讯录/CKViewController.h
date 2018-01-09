//
//  CKViewController.h
//  系统刷新
//
//  Created by slcf888 on 2018/1/8.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;
typedef void(^EditViewControllerBlock)(void);

@interface CKViewController : UIViewController

@property (nonatomic, strong) Contact *contant;
@property (nonatomic, strong)EditViewControllerBlock block;

@end
