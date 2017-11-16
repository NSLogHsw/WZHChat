//
//  WZHEmotionView.h
//  WZHChat
// 表情键盘
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZHTextAttachment.h"
#import "NSAttributedString+WZHEmojiExtension.h"

@protocol WZHEmotionViewdelegate <NSObject>

//发送，删除等按钮的代理事件，用tag值区按钮！
- (void)emotionView_sBtnDidClick:(UIButton *)btn;
//gif表情的代理事件！
- (void)gifBtnClick:(UIButton *)btn;
//代理方法，点击表情按钮触发方法
- (void)MoreWayBtnDidClicked:(UIButton *)moreWayBtn;

@end

@interface WZHEmotionView : UIImageView <UIScrollViewDelegate>

@property (nonatomic, strong) UITextView *IputView;      //textView，输入框
@property (nonatomic, strong) UIButton *sendBtn;         //发送按钮
@property (nonatomic, strong) UIButton *emojiBtn;        //底部条的按钮
@property (nonatomic, assign) id <WZHEmotionViewdelegate> delegate;
@property (nonatomic, strong) UIButton *moreWayButton;
@property (nonatomic, strong) NSString *number;

@end
