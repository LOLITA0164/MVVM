//
//  HomePageViewController.m
//  MVVM
//
//  Created by LOLITA0164 on 2019/9/19.
//  Copyright © 2019 LOLITA. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageTableViewCell.h"
#import "HomePageViewModel.h"

@interface HomePageViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl* freshControl;

@property (strong, nonatomic) HomePageViewModel* viewModel;

@end

@implementation HomePageViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 设置UI
-(void)setupUI{
    // 列表视图
    self.tableView.tableFooterView = UIView.new;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomePageTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(HomePageTableViewCell.class)];
    // 刷新控件
    self.tableView.refreshControl = self.freshControl;
}

-(void)setupLayout{}

#pragma mark - getter/setter
-(HomePageViewModel *)viewModel{
    if (_viewModel==nil) {
        _viewModel = HomePageViewModel.new;
    }
    return _viewModel;
}
-(UIRefreshControl *)freshControl{
    if (_freshControl==nil) {
        _freshControl = [UIRefreshControl new];
        _freshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"上刷新"];
    }
    return _freshControl;
}

#pragma mark - 双向绑定
-(void)bindSomething{
    @weakify(self);
    
    // 监听刷新
    [[RACObserve(self.viewModel, needRefresh) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [self.tableView reloadData];
            if (self.freshControl.refreshing) {
                [self.freshControl endRefreshing];
            }
        }
    }];
    
    // 监听上拉刷新
    [[self.freshControl rac_signalForControlEvents:UIControlEventValueChanged]
     subscribeNext:^(id x) {
         @strongify(self);
         [self.viewModel requestSomething];
    }];
}

#pragma mark - 获取数据
-(void)requestData{
    [self.viewModel requestSomething];
}

#pragma mark - 视图代理
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataList.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomePageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HomePageTableViewCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HomePageModel* model = self.viewModel.dataList[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.subLabel.text = model.des;
    if (model.imageData) {
        cell.iconImageView.image = [UIImage imageWithData:model.imageData];
    } else {
        [[[model fetchImage] deliverOn:RACScheduler.mainThreadScheduler]
         subscribeNext:^(NSData* data) {
             cell.iconImageView.image = [UIImage imageWithData:model.imageData];
         }];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageModel* model = self.viewModel.dataList[indexPath.row];
    return model.cellHeight;
}



#pragma mark - 操作事件

#pragma mark - 其他私有方法


@end
