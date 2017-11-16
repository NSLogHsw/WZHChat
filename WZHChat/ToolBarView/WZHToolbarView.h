//
//  WZHToolbarView.h
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WZHToolBarDelegate <NSObject>

//代理方法，点击表情按钮触发方法
-(void)ToolbarEmotionBtnDidClicked:(UIButton *)emotionBtn;
//代理方法，点击语音按钮触发方法
-(void)ToolbarVoiceBtnDidClicked:(UIButton *)voiceBtn;
//代理方法，点击更多按钮触发方法
-(void)ToolbarMoreBtnDidClicked:(UIButton *)moreBtn;

@end

@interface WZHToolbarView : UIImageView

@property (nonatomic, assign) id <WZHToolBarDelegate> delegate;     //toolbar代理
@property (nonatomic, strong) UIView *toolBarView;
@property (nonatomic, strong) UIButton *btn_recycle;
@property (nonatomic, strong) UITextView *textView;       //toolbar上面的输入框
@property (nonatomic, strong) UIButton *toolBarEmotionBtn;      //表情按钮
@property (nonatomic, strong) UIButton *toolBarVoiceBtn;        //语音按钮
@property (nonatomic, strong) UIButton *toolBarMoreBtn;      //更多按钮

@end
