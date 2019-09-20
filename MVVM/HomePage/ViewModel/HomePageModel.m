//
//  HomePageModel.m
//  MVVM
//
//  Created by LOLITA0164 on 2019/9/19.
//  Copyright © 2019 LOLITA. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel


// 拉取图片资源
-(RACSignal*)fetchImage{
    @weakify(self)
    RACScheduler* scheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground];
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageUrl]];
        self.imageData = data;
        [subscriber sendNext:data];
        [subscriber sendCompleted];
        return nil;
    }] subscribeOn:scheduler];
}

@end
