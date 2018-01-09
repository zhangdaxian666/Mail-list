//
//  Contact.h
//  系统刷新
//
//  Created by slcf888 on 2018/1/8.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;

+ (instancetype)contanctWithName:(NSString *)name phone:(NSString *)phone;

+ (BOOL)checkPhone:(NSString *)phoneNumber;
//+ (BOOL)checkPhone:(NSString *)phoneNumber message:(NSString *)message;
@end
