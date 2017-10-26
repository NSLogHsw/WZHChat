//
//  WZHChtaDetailViewController.h
//  WZHChat
//
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKBaseWithBaseViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface WZHChtaDetailViewController :AKBaseWithBaseViewController

@property (strong, nonatomic) AVAudioSession *session;
@property (strong, nonatomic) AVAudioRecorder *record;
@property (assign, nonatomic) NSTimer *timer;
@property (copy, nonatomic) NSString *filePath;
@property (strong, nonatomic) AVAudioPlayer *player;

@end
