//
//  Contact.m
//  系统刷新
//
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
@end
