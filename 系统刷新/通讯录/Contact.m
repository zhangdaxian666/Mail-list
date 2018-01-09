//
//  Contact.m
//  系统刷新
//  https://www.jianshu.com/p/516b49bc2c40
//  Created by slcf888 on 2018/1/8.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import "Contact.h"

@implementation Contact
static NSString *nameKey = @"name";
static NSString *phoneKey = @"phone";

+ (instancetype)contanctWithName:(NSString *)name phone:(NSString *)phone
{
    Contact *cx = [[self alloc]init];
    cx.name = name;
    cx.phone = phone;
    return cx;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    //姓名电话号码
    [aCoder encodeObject:_name forKey:nameKey];
    [aCoder encodeObject:_phone forKey:phoneKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        _name = [aDecoder decodeObjectForKey:nameKey];
        _phone = [aDecoder decodeObjectForKey:phoneKey];
    }
    return self;
}

+ (BOOL)checkPhone:(NSString *)phoneNumber 

{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    if (!isMatch)
    {
        return NO;
    }
    return YES;
}

//判断手机⬆️判断邮箱⬇️
//+ (BOOL)checkEmail:(NSString *)email{
//
//    //^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w{2,3}){1,3})$
//
//    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
//
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//
//    return [emailTest evaluateWithObject:email];
//
//}
@end
