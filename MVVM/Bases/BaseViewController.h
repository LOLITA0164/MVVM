//
//  BaseViewController.h
//  MVVM
//
//  Created by LOLITA0164 on 2019/9/19.
//  Copyright © 2019 LOLITA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewModel.h"

@interface BaseViewController : UIViewController

/// 初始化UI
-(void)setupUI;
/// 视图层布局
-(void)setupLayout;

/// 双向绑定
-(void)bindSomething;

/// 数据获取的入口
-(void)requestData;

@end

