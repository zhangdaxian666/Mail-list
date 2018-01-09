//
//  TJViewController.h
//  系统刷新
//
//  Created by slcf888 on 2018/1/8.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJViewController,Contact;

@class TableViewController;

typedef void(^AddViewControllerBlock)(Contact *contant); //block

@interface TJViewController : UIViewController

@property (nonatomic,strong)AddViewControllerBlock blocked;

@end
