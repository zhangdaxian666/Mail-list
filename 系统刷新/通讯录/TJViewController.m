//
//  TJViewController.m
//  系统刷新
//  https://www.jianshu.com/p/516b49bc2c40
//  Created by slcf888 on 2018/1/8.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import "TJViewController.h"
#import "Contact.h"
#import "TableViewController.h"

@interface TJViewController ()
@property (weak, nonatomic) IBOutlet UITextField *peopleField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation TJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_peopleField addTarget:self action:@selector(VailChange) forControlEvents:UIControlEventEditingChanged];
    [_phoneField addTarget:self action:@selector(VailChange) forControlEvents:UIControlEventEditingChanged];
    
    // Do any additional setup after loading the view.
}
//
- (void)viewWillAppear:(BOOL)animated
{
    [self viewDidAppear:animated];
    [_peopleField becomeFirstResponder];
}

- (IBAction)AddBack:(id)sender {
    if (_phoneField.text.length == 11) {
        
//        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
//
//        NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
//        NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
//        NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        
        if ([Contact checkPhone:_phoneField.text]) {
            //文本包装为模型
            Contact *vc = [Contact contanctWithName:_peopleField.text phone:_phoneField.text];
            
            if (_blocked) {
                _blocked(vc);
            }
            //fanhui
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertController * allertController = [UIAlertController alertControllerWithTitle:@"您输入的手机号格式不正确" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [allertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:allertController animated:YES completion:nil];
        }
        
    }else{
        UIAlertController * allertController = [UIAlertController alertControllerWithTitle:@"您输入的手机号格式不正确" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [allertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:allertController animated:YES completion:nil];
    }
    
}
- (void)VailChange{
    _addBtn.enabled = _peopleField.text.length && _phoneField.text.length;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
