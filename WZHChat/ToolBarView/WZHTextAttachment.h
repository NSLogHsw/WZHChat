//
//  WZHTextAttachment.h
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    //gif
    WZHEmotionTypeGif,
    //静态图
    WZHEmotionTypePng,
} WZHEmotionType;

@interface WZHTextAttachment : NSTextAttachment

@property (nonatomic, strong) NSString *emojiTag;       //用来记录区分表情
@property (nonatomic, assign) CGSize emojiSize;         //表情尺寸

@end
