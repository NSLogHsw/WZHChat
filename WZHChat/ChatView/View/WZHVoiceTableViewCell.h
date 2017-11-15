//
//  WZHVoiceTableViewCell.h
//  WebPageMaster
//
//  Created by 吳梓杭 on 2017/10/20.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LGVoicePlayState){
    LGVoicePlayStateNormal,/**< 未播放状态 */
    LGVoicePlayStateDownloading,/**< 正在下载中 */
    LGVoicePlayStatePlaying,/**< 正在播放 */
    LGVoicePlayStateCancel,/**< 播放被取消 */
};
@protocol WZHVoiceDelegate <NSObject>

- (void)VoiceClicked:(UIButton *)voiceBtn;
- (void)ChatMessageClicked:(UILongPressGestureRecognizer *)longBtn;

@end

@interface WZHVoiceTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *lab_time;
@property (nonatomic, strong) UILabel *lab_name;
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UIImageView *conversationView;
@property (nonatomic, strong) UIButton *btn_voice;
@property (nonatomic, strong) NSDate *timeDate;
@property (nonatomic, strong) NSString *currentRecordTime;
@property (nonatomic, strong) UILabel *lab_currentRecordTime;
@property (nonatomic, assign) id <WZHVoiceDelegate> delegate;

- (void)initWithTimeStr:(NSString *)timeStr HeaderStr:(NSString *)headerStr NameStr:(NSString *)nameStr CurrentRecordTime:(NSString *)currentRecordTime Guest:(NSString *)guestStr RecordTag:(NSInteger)recordTag;

@end

