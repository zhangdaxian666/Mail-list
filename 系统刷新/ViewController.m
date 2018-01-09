//
//  ViewController.m
//  系统刷新
//
//  Created by slcf888 on 2018/1/5.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import "ViewController.h"
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,WIDTH,HEIGHT)];
    //滚动视图的代理
    self.scrollView.delegate =self;
    
    self.scrollView.backgroundColor = [UIColor yellowColor];
    //只要创建出UIRefreshControl即可。
    self.scrollView.refreshControl  = [[UIRefreshControl alloc]init];
    self.scrollView.refreshControl.tintColor = [UIColor cyanColor];
    //添加标题
    self.scrollView.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    
    //背景色：刷新控制器的背景
    self.scrollView.refreshControl.backgroundColor = [UIColor whiteColor];
    // 添加刷新方法
    [self.scrollView.refreshControl addTarget:self action:@selector(downloadData) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.scrollView];
    
    //设置为NO刷新控制器失效
    self.scrollView.bounces =YES;
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - 在这里实现下拉数据的加载
- (void)downloadData{
    NSLog(@"加载新数据");
}

#pragma mark - UIRefreshControl的开始刷新的方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    NSLog(@"即将开始拖拽");
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"即将开始减速");
}
#pragma mark - UIRefreshControl的停止刷新的方法
 //停止下拉后，延迟1s左右完成减速后停止刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.scrollView.refreshControl endRefreshing];
}
  //停止下拉拖拽后立即停止刷新
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.scrollView.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
