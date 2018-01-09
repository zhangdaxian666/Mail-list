//
//  DLViewController.m
//  系统刷新
// http://blog.csdn.net/frank_jb/article/details/47829909
//  Created by slcf888 on 2018/1/8.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import "DLViewController.h"
#import <SVProgressHUD.h>
#define CDDNSUserDefaults [NSUserDefaults standardUserDefaults]

@interface DLViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwdFiled; //账号
@property (weak, nonatomic) IBOutlet UITextField *accountFiled; //密码

@property (weak, nonatomic) IBOutlet UISwitch *rmbPwd; //记住密码
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin; //自动登陆

@property (weak, nonatomic) IBOutlet UIButton *login; //登陆

@end
static NSString *accountKey = @"account";
static NSString *pwdKey = @"pwd";
static NSString *autoLoginKey = @"autoLogin";
static NSString *rmbPwdKey = @"rmbPwd";

@implementation DLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi) name:@"self" object:nil];
    //读取数据   NSUserDefaults
    NSString *account = [CDDNSUserDefaults objectForKey:accountKey];
    NSString *pwd = [CDDNSUserDefaults objectForKey:pwdKey];
    BOOL autoLogin = [CDDNSUserDefaults boolForKey:autoLoginKey];
    BOOL rmbPwd = [CDDNSUserDefaults boolForKey:rmbPwdKey];
    
    _pwdFiled.text = account;
    if (rmbPwd == YES) {
        _accountFiled.text = pwd;
    }
    _rmbPwd.on = rmbPwd;
    _autoLogin.on = autoLogin;
    
    if (autoLogin == YES) {
        [self Login:nil];
    }
    
    [_pwdFiled addTarget:self action:@selector(VailChange) forControlEvents:UIControlEventEditingChanged];
    [_accountFiled addTarget:self action:@selector(VailChange) forControlEvents:UIControlEventEditingChanged];

    //判断登陆按钮是否可以点击
    [self VailChange];
    
    // Do any additional setup after loading the view.
}
- (void)tongzhi{
    _accountFiled.text = nil;
    _rmbPwd.on = NO;
}
- (IBAction)rmbPwd:(id)sender {
    if (_rmbPwd.on == NO) {
        [_autoLogin setOn:NO animated:YES];
    }
}
- (IBAction)autoLogin:(id)sender {
    if (_autoLogin.on == YES) {
        [_rmbPwd setOn:YES animated:YES];
    }
}
//登陆
- (IBAction)Login:(id)sender {
    //与
    if ([_pwdFiled.text isEqualToString:@"666"] && [_accountFiled.text isEqualToString:@"666"]) {
        //开始储存
        [CDDNSUserDefaults setObject:_accountFiled.text forKey:accountKey];
        [CDDNSUserDefaults setObject:_pwdFiled.text forKey:pwdKey];
        [CDDNSUserDefaults setBool:_autoLogin.on forKey:autoLoginKey];
        [CDDNSUserDefaults setBool:_rmbPwd.on forKey:rmbPwdKey];
       
        [self showprogress];
        //在xib push 里下表示identifiler里  必用整个页面推
        [self performSegueWithIdentifier:@"cocoa" sender:self];
    }else{
        [self showError];
    }
}
- (void)showprogress{
    [SVProgressHUD showProgress:0 status:@"加载中"];
    [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1];
}
- (void)showError{
    [SVProgressHUD showErrorWithStatus:@"账号或密码不正确"];
    [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1];
}
- (void)dismiss:(id)sender{
    [SVProgressHUD dismiss];
}

//监听账号密码都有值时，点击
- (void)VailChange
{
    _login.enabled = _accountFiled.text.length && _pwdFiled.text.length;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma 导航条正上头的标题，及登陆人
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = segue.destinationViewController;
    vc.title = [NSString stringWithFormat:@"%@的联系人列表",_pwdFiled.text];
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

@end
