//
//  TableViewController.m
//  系统刷新
//
//  Created by slcf888 on 2018/1/8.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import "TableViewController.h"
#import "DLViewController.h"
#import "TJViewController.h"
#import "Contact.h"
#import "CKViewController.h"
#import <SVProgressHUD.h>
#define CDDFilePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"contacts.data"]

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation TableViewController

- (NSMutableArray *)contacts
{
    if (_contacts == nil) {
        //读取本地数据
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:CDDFilePath];
        
        if (_contacts == nil) {
            _contacts = [NSMutableArray array];
        }
    }
    return _contacts;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UITableView alloc]init];
    //  取消分割线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//在其他类里实现代理方法时，代理返回可以用segue  获取目标控制器，将代理给当前类ContactsViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //给控制器传递联系人属性
    TJViewController *vc = segue.destinationViewController;
    vc.blocked = ^(Contact *contant) {
        //把联系人保存到数组里
        [self.contacts addObject:contant];
        //刷新
        [self.tableView reloadData];
      
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:CDDFilePath];
    };
}
- (IBAction)Back:(id)sender {
    UIAlertController * allertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [allertController addAction:[UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //可发一个通知密码消失
        [[NSNotificationCenter defaultCenter] postNotificationName:@"self" object:self];
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [allertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:allertController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cdd"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cdd"];
    }
    Contact *vc = self.contacts[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"姓名:%@",vc.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"电话:%@",vc.phone];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //整个页面 又边选第三个设置storyborad ID
    CKViewController *avc = [storyboard instantiateViewControllerWithIdentifier:@"edit"];
    avc.contant = _contacts[indexPath.row];
    
    avc.block = ^{
        [self.tableView reloadData];
        
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:CDDFilePath];
    };
    [self.navigationController pushViewController:avc animated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.contacts removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //刷新
    [self.tableView reloadData];
    
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:CDDFilePath];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
