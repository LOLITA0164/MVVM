//
//  HomePageViewModel.m
//  MVVM
//
//  Created by LOLITA0164 on 2019/9/19.
//  Copyright © 2019 LOLITA. All rights reserved.
//

#import "HomePageViewModel.h"

@implementation HomePageViewModel

// 这里仅作模拟像服务器/本地数据库获取数据
-(void)requestSomething{
    self.needRefresh = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray* tmp = [NSMutableArray array];
        int count = arc4random() % 10 + 1;
        for (int i=0; i<count; i++) {
            HomePageModel* model = HomePageModel.new;
            model.imageUrl = @"http://attach.bbs.miui.com/forum/201402/19/173900f222xs2ut11x2wff.png";
            model.title = [NSString stringWithFormat:@"%ld - %u",(self.page*20+i+1), arc4random()];
            model.des = [NSString stringWithFormat:@"%u", arc4random()];
            model.cellHeight = i % 5 * 10 + 50;
            [tmp addObject:model];
        }
        self.dataList = tmp.copy;
        self.needRefresh = YES;
    });
}



@end
