//
//  BaseViewController.m
//  MVVM
//
//  Created by LOLITA0164 on 2019/9/19.
//  Copyright © 2019 LOLITA. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - 页面的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupLayout];
    [self bindSomething];
    [self requestData];
}

// 监听释放
-(void)dealloc{
    NSLog(@"%@ %@",NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

#pragma mark - 设置UI
-(void)setupUI{}
-(void)setupLayout{}

#pragma mark - getter/setter

#pragma mark - 双向绑定
-(void)bindSomething{}

#pragma mark - 获取数据
-(void)requestData{}

#pragma mark - 视图代理

#pragma mark - 操作事件

#pragma mark - 其他私有方法


@end
