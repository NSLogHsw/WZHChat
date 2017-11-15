//
//  WZHChatService.m
//  
//
//  Created by 吳梓杭 on 2017/10/20.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#define COMPARETIMESTR @"compareTimeStr"

#import "WZHChatService.h"

@implementation WZHChatService
@synthesize compareTimeStr = _compareTimeStr;

+ (WZHChatService *)sharedInstance {
    static WZHChatService *service = nil;
    if(service){
        return service;
    }
    service = [[WZHChatService alloc] init];
    return service;
}

- (BOOL)accessUserDefaultWithKey:(NSString *)key {
    id isValue =GetUserValue(key);
    return (isValue) ? YES : NO;
}
- (NSString *)compareTimeStr {
    if (!_compareTimeStr) {
        BOOL isCompareTimeStr = [self accessUserDefaultWithKey:COMPARETIMESTR];
        _compareTimeStr =(isCompareTimeStr) ? GetUserValue(COMPARETIMESTR) : nil;
    }
    return _compareTimeStr;
}
@end
