//
//  BaseViewModel.h
//  MVVM
//
//  Created by LOLITA0164 on 2019/9/19.
//  Copyright © 2019 LOLITA. All rights reserved.
//

/*
 该类是View-Model的基础类，配置一些公共资源
 */

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <Foundation/Foundation.h>

@interface BaseViewModel : NSObject
// 分页数
@property (assign, nonatomic) NSInteger page;
// 数据数组
@property (strong, nonatomic) NSArray* dataList;
// 需要刷新
@property (assign, nonatomic) BOOL needRefresh;
// 一些额外配置数据
@property (strong, nonatomic) NSDictionary* extension;

// 请求方法，这里进行模拟请求
-(void)requestSomething;

@end

