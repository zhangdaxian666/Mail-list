//
//  CKViewController.m
//  系统刷新
//
//  Created by slcf888 on 2018/1/8.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import "CKViewController.h"
#import "Contact.h"

@interface CKViewController ()
@property (weak, nonatomic) IBOutlet UITextField *editPeopleField;
@property (weak, nonatomic) IBOutlet UITextField *editPhoneField;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@end

@implementation CKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑修改";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:0 target:self action:@selector(editback)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:0 target:self action:@selector(change:)];
    
    _saveBtn.hidden = YES;
    _editPhoneField.enabled = NO; //enabled启用
    _editPeopleField.enabled = NO;
    
    _editPeopleField.text = _contant.name;
    _editPhoneField.text = _contant.phone;
    
    // Do any additional setup after loading the view.
}
- (void)editback{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)change:(UIBarButtonItem *)item{
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"取消";
        _saveBtn.hidden = NO;
        _editPeopleField.enabled = YES;
        _editPhoneField.enabled = YES;
        [_editPhoneField becomeFirstResponder];
    }else{
        item.title = @"编辑";
        _contant.name = _editPeopleField.text;
        _contant.phone = _editPhoneField.text;
        
        _editPeopleField.enabled = NO;
        _editPhoneField.enabled = NO;
        _saveBtn.hidden = YES;
    }
}
- (IBAction)saveBtn:(id)sender {
    if (_editPhoneField.text.length == 11) {
        //重新赋值
        _contant.name = _editPeopleField.text;
        _contant.phone = _editPhoneField.text;
        
        if (_block) {
            _block(); //I don't Know
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertController * allertController = [UIAlertController alertControllerWithTitle:@"手机号格式不正确" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [allertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:allertController animated:YES completion:nil];
    }
   
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
