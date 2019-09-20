//
//  LoginViewController.m
//  MVVM
//
//  Created by LOLITA0164 on 2019/9/19.
//  Copyright © 2019 LOLITA. All rights reserved.
//

#import "LoginViewController.h"
#import "HomePageViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;

@property (strong, nonatomic) LoginViewModel* viewModel;

@end

@implementation LoginViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - 设置UI
-(void)setupUI{
    self.signInFailureText.hidden = YES;
}

#pragma mark - getter/setter
-(LoginViewModel *)viewModel{
    if (_viewModel==nil) {
        _viewModel = LoginViewModel.new;
    }
    return _viewModel;
}

#pragma mark - 双向绑定
-(void)bindSomething{
    
    // 账号信号
    RACSignal* usernameSignal = self.usernameTextField.rac_textSignal;
    // 密码信号
    RACSignal* passwordSignal = self.passwordTextField.rac_textSignal;
    // 组合信号
    RACSignal* combineSignal = [RACSignal combineLatest:@[usernameSignal, passwordSignal] reduce:^id(NSString* username, NSString* password){
        return @(username.length >= 3 && password.length >= 3);
    }];
    
    // 绑定到数据模型和VM
    RAC(self.viewModel, username) = usernameSignal;
    RAC(self.viewModel, password) = passwordSignal;
    RAC(self.viewModel, enable) = combineSignal;
    
    // 绑定到视图
    RAC(self.usernameTextField, backgroundColor) = [RACObserve(self.viewModel, username) map:^id(NSString* text) {
        return text.length >= 3 ? [UIColor.greenColor colorWithAlphaComponent:0.1] : UIColor.clearColor;
    }];
    RAC(self.passwordTextField, backgroundColor) = [RACObserve(self.viewModel, password) map:^id(NSString* text) {
        return text.length >= 3 ? [UIColor.greenColor colorWithAlphaComponent:0.1] : UIColor.clearColor;
    }];
    RAC(self.signInButton, enabled) = RACObserve(self.viewModel, enable);
    
    
    @weakify(self)
    // 创建按钮点击事件信号
    RACSignal* loginSigal = [self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    [[[loginSigal doNext:^(id x) {
        @strongify(self)
        self.signInFailureText.hidden = YES;
        self.signInButton.enabled = NO;
        [self.view endEditing:YES];
    }]
      flattenMap:^RACStream *(id value) {
        @strongify(self)
        return [self loginSignal];
    }]
     subscribeNext:^(id x) {
         @strongify(self)
         self.signInButton.enabled = YES;
         self.signInFailureText.hidden = [x boolValue];
         if ([x boolValue]) {   // 登录成功
             [self goToHomePage];
         }
    }];
    

}

#pragma mark - 获取数据

#pragma mark - 视图代理

#pragma mark - 操作事件

#pragma mark - 其他私有方法
/// 创建登录请求的信号
-(RACSignal*)loginSignal{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        [self.viewModel loginWithComplete:^(BOOL succeed) {
            [subscriber sendNext:@(succeed)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

/// 跳转首页
-(void)goToHomePage{
    HomePageViewController* ctrl = [HomePageViewController new];
    UINavigationController* navCtrl = [[UINavigationController alloc] initWithRootViewController:ctrl];
    UIWindow* window = UIApplication.sharedApplication.keyWindow;
    window.rootViewController = navCtrl;
    [window.layer addAnimation:self.transition forKey:@"tr"];
}

-(CATransition*)transition{
    CATransition* tr = CATransition.new;
    tr.type = kCATransitionPush;
    tr.subtype = kCATransitionFromRight;
    return tr;
}


@end
