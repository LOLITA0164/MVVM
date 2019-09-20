//
//  LoginViewModel.m
//  MVVM
//
//  Created by LOLITA0164 on 2019/9/19.
//  Copyright © 2019 LOLITA. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

// 登录请求
-(void)loginWithComplete:(LoginInResponse)completeBlock{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BOOL success = [self.username isEqualToString:@"user"] && [self.password isEqualToString:@"password"];
        completeBlock(success);
    });
}



@end
