//
//  TJViewController.m
//  系统刷新
//
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
    //文本包装为模型
    Contact *vc = [Contact contanctWithName:_peopleField.text phone:_phoneField.text];
    
    if (_blocked) {
        _blocked(vc);
    }
    //fanhui
    [self.navigationController popViewControllerAnimated:YES];
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
