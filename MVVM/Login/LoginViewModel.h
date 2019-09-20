//
//  LoginViewModel.h
//  MVVM
//
//  Created by LOLITA0164 on 2019/9/19.
//  Copyright © 2019 LOLITA. All rights reserved.
//

#import "BaseViewModel.h"

typedef void (^LoginInResponse)(BOOL);

@interface LoginViewModel : BaseViewModel

@property (copy, nonatomic) NSString* username;
@property (copy, nonatomic) NSString* password;
@property (assign, nonatomic) BOOL enable;

// 登录请求
-(void)loginWithComplete:(LoginInResponse)completeBlock;

@end

