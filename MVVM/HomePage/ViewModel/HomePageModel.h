//
//  HomePageModel.h
//  MVVM
//
//  Created by LOLITA0164 on 2019/9/19.
//  Copyright © 2019 LOLITA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface HomePageModel : NSObject
// 头像
@property (strong, nonatomic) NSString* imageUrl;
@property (strong, nonatomic) NSData* imageData;
// 标题
@property (strong, nonatomic) NSString* title;
// 子标题
@property (strong, nonatomic) NSString* des;
// cell高度
@property (assign, nonatomic) float cellHeight;

// 拉取图片资源
-(RACSignal*)fetchImage;

@end

