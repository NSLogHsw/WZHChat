//
//  WZHEmotionView.m
//  WZHChat
//  表情键盘
//  Created by 吳梓杭 on 2017/10/18.
//  Copyright © 2017年 吳梓杭. All rights reserved.
//

#import "WZHEmotionView.h"
#import "UIView+WZHExtension.h"

static NSDictionary *_emotionGifTitle;
static NSArray      *_emojiTags;
static NSDictionary *_emojiStaticImages;

#define pages 7
#define emojiCount 21
#define rowCount 7
#define emotionW IPHONE_WIDTH * 0.0875
#define rows 3
#define emotionBtnsCount 2
#define gifW IPHONE_WIDTH * 0.15625
#define gifH IPHONE_WIDTH * 0.22
#define gifCount 24
#define gifRowCount 4

@interface WZHEmotionView ()

@property (nonatomic, assign) CGFloat EMOJI_MAX_SIZE;      //表情大小需要根据字体计算
@property (nonatomic, weak) UIPageControl *pageControl;    //键盘的pageControl
@property (nonatomic, strong) UIImageView  *emotonViewPageOne;      //以下是放表情按钮的视图，多页（这样做有些low）
@property (nonatomic, strong) UIImageView  *emotonViewPageTwo;
@property (nonatomic, strong) UIImageView  *emotonViewPageThree;
@property (nonatomic, strong) UIImageView  *emotonViewPageFour;
@property (nonatomic, strong) UIImageView  *emotonViewPageFive;
@property (nonatomic, strong) UIImageView  *emotonViewPageSix;
@property (nonatomic, strong) UIImageView  *emotonViewPageSeven;
@property (nonatomic, strong) UIScrollView  *pageView;        //用来放上边页面的scrollview
@property (nonatomic, strong) UIFont *font;       //字体大小，用来计算表情尺寸
@property (nonatomic, assign) CGFloat gap;        //间距
@property (nonatomic, strong) UIScrollView *scrollBtnsView;      //底部按钮条，现在用不到，当多表情类型多的时候可以滑动
@property (nonatomic, strong) UIButton *btnsBar;        //用来放底部按钮横条
@property (nonatomic, strong) UIButton *emotionBtn;      //普通表情
@property (nonatomic, strong) UIButton *springBtn;

@end


@implementation WZHEmotionView

//当输入框被赋值时执行这个方法
- (void)setIputView:(UITextView *)IputView {
    _IputView = IputView;
    [self setSomeProperty];
}

//初始化一些数据，计算按钮大小，根据输入框的字体
- (void)setSomeProperty {
    if (!self.IputView.font)
    {self.IputView.font = [UIFont systemFontOfSize:17];}
    self.font = self.IputView.font;
    _EMOJI_MAX_SIZE = [self heightWithFont:self.IputView.font];
}

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initEmojiDatas];
        //创建滚动视图
        [self creatScorllView];
        //创建表情视图
        [self creatEmotionViews];
        //创建按钮
        [self creatPageViewBtnsWithEmojiTag:1 DeleteTag:211 EmotonView:self.emotonViewPageOne];
        [self creatPageViewBtnsWithEmojiTag:21 DeleteTag:212 EmotonView:self.emotonViewPageTwo];
        [self creatPageViewBtnsWithEmojiTag:41 DeleteTag:213 EmotonView:self.emotonViewPageThree];
        [self creatPageViewBtnsWithEmojiTag:61 DeleteTag:214 EmotonView:self.emotonViewPageFour];
        [self creatPageViewBtnsWithEmojiTag:81 DeleteTag:215 EmotonView:self.emotonViewPageFive];
        [self creatPageViewBtnsWithEmojiTag:101 DeleteTag:216 EmotonView:self.emotonViewPageSix];
        [self creatPageViewBtnsWithEmojiTag:121 DeleteTag:217 EmotonView:self.emotonViewPageSeven];
        //创建pagecontrol
        [self creatPageControl];
        //创建底部按钮栏
        [self creatBottomBar];
    }
    return self;
}

//加载plist文件中的对照表
- (void)initEmojiDatas {
    self.sendBtn.enabled = NO;
    self.userInteractionEnabled = YES;
    self.gap = (IPHONE_WIDTH - rowCount * emotionW) / (rowCount + 1);
    NSString *staPath  = [[NSBundle mainBundle] pathForResource:@"WZHEmoji" ofType:@"plist"];
    NSString *gifPath  = [[NSBundle mainBundle] pathForResource:@"WZHGifEmoji" ofType:@"plist"];
    NSString *tagPath  = [[NSBundle mainBundle] pathForResource:@"WZHEmotionTags" ofType:@"plist"];
    _emojiTags = [NSArray arrayWithContentsOfFile:tagPath];
    _emotionGifTitle   = [NSDictionary dictionaryWithContentsOfFile:gifPath];
    _emojiStaticImages = [NSDictionary dictionaryWithContentsOfFile:staPath];
}

//创建btnsBar
- (void)creatBottomBar {
    //    [self cteateBottomBtnBar];
    //    [self createSendBtn];
    [self createScrollBtnsView];
}

//创建底部按钮栏
- (void)cteateBottomBtnBar {
    UIButton *btnsBar = [[UIButton alloc]initWithFrame:CGRectMake(0, self.emotonViewPageOne.frame.size.height + 15, IPHONE_WIDTH, emotionW + 5)];
    self.btnsBar = btnsBar;
    btnsBar.userInteractionEnabled = YES;
    [self addSubview:btnsBar];
}

// 发送按钮
- (void)createSendBtn {
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(IPHONE_WIDTH * 6 / 7, 0, IPHONE_WIDTH / 7, _btnsBar.frame.size.height)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    sendBtn.tag = 3456;
    [sendBtn addTarget:self action:@selector(emotionBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [sendBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:37.0 / 255.0 green:139.0 / 255.0 blue:277.0 / 255.0 alpha:1.0f]] forState:UIControlStateSelected];
    self.sendBtn = sendBtn;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, sendBtn.frame.size.height)];
    lineView.backgroundColor = D7D7D7;
    [sendBtn addSubview:lineView];
    [_btnsBar addSubview:sendBtn];
}

//创建滚动按钮条
- (void)createScrollBtnsView {
    self.scrollBtnsView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH * 6 / 7, emotionW + 5)];
    self.scrollBtnsView.backgroundColor = EEEEEE;
    [self.btnsBar addSubview:self.scrollBtnsView];
    //创建表情切换按钮
    [self createEmotionBtns];
}

//创建不同类型的表情按钮
- (void)createEmotionBtns {
    UIButton *emotionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH / 7, _btnsBar.frame.size.height)];
    emotionBtn.backgroundColor = [UIColor whiteColor];
    [emotionBtn addTarget:self action:@selector(emotionBtnsClick:) forControlEvents:UIControlEventTouchUpInside];
    [emotionBtn setBackgroundImage:[UIImage createImageWithColor:C9C9C9] forState:UIControlStateSelected];
    emotionBtn.selected = YES;
    self.emotionBtn = emotionBtn;
    self.emojiBtn = emotionBtn;
    [emotionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
}

//创建表情按钮（多个页面的）
- (void)creatPageViewBtnsWithEmojiTag:(NSInteger)emojiTag DeleteTag:(NSInteger)deleteTag EmotonView:(UIImageView *)emotonView {
    int row = 1;
    CGFloat space = (IPHONE_WIDTH - rowCount * emotionW) / (rowCount + 1);
    for (int i = 0; i < emojiCount; i ++) {
        row = i / rowCount + 1;
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake((1 + i - (rowCount * (row - 1))) * space + (i - (rowCount * (row - 1))) * emotionW, space * row + (row - 1) * emotionW, emotionW, emotionW);
        btn.tag = i + emojiTag;
        if (i == emojiCount - 1) {
            btn.tag = deleteTag;
            [btn setImage:[UIImage imageNamed:@"backDelete"] forState:UIControlStateNormal];
            btn.size = CGSizeMake(emotionW + space, emotionW + space);
            CGFloat X = btn.x;
            CGFloat Y = btn.y;
            btn.x = X - space / 3;
            btn.y = Y - space / 3;
            [btn addTarget:self action:@selector(deleteBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        }else {
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"[%ld]",(long)btn.tag]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(insertEmoji:) forControlEvents:UIControlEventTouchUpInside];
        }
        [emotonView addSubview:btn];
    }
    UIButton *btnsBar = [[UIButton alloc]initWithFrame:CGRectMake(0, rows * emotionW +(rows + 1) * self.gap, IPHONE_WIDTH, emotionW + 5)];
    self.btnsBar = btnsBar;
    btnsBar.userInteractionEnabled = YES;
    [emotonView addSubview:btnsBar];
    
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(IPHONE_WIDTH * 6 / 7, 0, IPHONE_WIDTH / 7, _btnsBar.frame.size.height)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sendBtn.tag = 3456;
    [sendBtn addTarget:self action:@selector(emotionBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage createImageWithColor:EEEEEE] forState:UIControlStateNormal];
    self.sendBtn = sendBtn;
    [_btnsBar addSubview:sendBtn];
}

//表情视图
- (void)creatEmotionViews {
    //表情展示视图
    for (int i = 0; i < pages; i ++) {
        UIImageView *emotionPageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * IPHONE_WIDTH, 0, IPHONE_WIDTH, rows * emotionW +(rows + 1) * self.gap + emotionW + 5)];
        emotionPageView.backgroundColor = EEEEEE;
        emotionPageView.userInteractionEnabled = YES;
        if (i == 0) {
            self.emotonViewPageOne = emotionPageView;
        } else if (i == 1) {
            self.emotonViewPageTwo = emotionPageView;
        }else if (i == 2) {
            self.emotonViewPageThree = emotionPageView;
        }else if (i == 3) {
            self.emotonViewPageFour = emotionPageView;
        }else if (i == 4) {
            self.emotonViewPageFive = emotionPageView;
        }else if (i == 5) {
            self.emotonViewPageSix = emotionPageView;
        }else if (i == 6) {
            self.emotonViewPageSeven = emotionPageView;
        }
        [_pageView addSubview:emotionPageView];
    }
}

//滚动视图
- (void)creatScorllView {
    //滚动视图
    UIScrollView *pageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, rows * emotionW +(rows + 1) * self.gap+ emotionW + 5)];
    pageView.backgroundColor = [UIColor clearColor];
    pageView.bounces = NO;
    pageView.pagingEnabled = YES;
    pageView.showsHorizontalScrollIndicator = NO;
    pageView.contentSize = CGSizeMake(IPHONE_WIDTH * pages, rows * emotionW +(rows + 1) * self.gap+ emotionW + 5);
    pageView.delaysContentTouches = YES;
    pageView.delegate = self;
    self.pageView = pageView;
    [self addSubview:pageView];
}

//pagecontrol
- (void)creatPageControl {
    UIPageControl *pagecontrol = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.emotonViewPageOne.frame.size.height, IPHONE_WIDTH / 35, 15)];
    pagecontrol.numberOfPages = 7;
    pagecontrol.currentPage = 0;
    pagecontrol.pageIndicatorTintColor = [UIColor lightGrayColor];
    pagecontrol.currentPageIndicatorTintColor = [UIColor grayColor];
    pagecontrol.hidesForSinglePage = YES;
    pagecontrol.backgroundColor = EEEEEE;
    self.pageControl = pagecontrol;
    [self addSubview:pagecontrol];
}

//点击表情时，插入图片到输入框
- (void)insertEmoji:(UIButton *)btn {
    //创建自定义的附件
    WZHTextAttachment *emojiTextAttachment = [WZHTextAttachment new];
    //    给附件设置tag值(用来对照图片；通过前边从plist中加载到的数组_emojiTags中取到按钮对应的字符串)
    emojiTextAttachment.emojiTag = _emojiTags[(NSUInteger) btn.tag - 1];
    NSString *imageName;
    //下边这个判断可以不管，是我在测试新加载方案的调试代码。下边方法就是要取到当前按钮对应的图片名字
    if (btn.tag > 140) {
        NSString *shortName = [_emojiStaticImages objectForKey:_emojiTags[(NSUInteger) btn.tag - 1]];
        imageName = [NSString stringWithFormat:@"%@.gif",shortName];
    }else {
        imageName = [_emojiStaticImages objectForKey:_emojiTags[(NSUInteger) btn.tag - 1]];
    }
    //给附件设置图片
    emojiTextAttachment.image = [UIImage imageNamed:imageName];
    //    给附件设置尺寸,会在自定义附件内部重写方法用这个值来设置附件尺寸
    emojiTextAttachment.emojiSize = CGSizeMake(_EMOJI_MAX_SIZE, _EMOJI_MAX_SIZE);
    //textview插入富文本，用创建的附件初始化富文本
    [_IputView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:emojiTextAttachment] atIndex:_IputView.selectedRange.location];
    _IputView.selectedRange = NSMakeRange(_IputView.selectedRange.location + 1, _IputView.selectedRange.length);
    //调用这个方法是为了响应代理方法，目的是触发输入框改变时候的事件，比如表情输入时候需要改变输入框的高度等，设计的比较多！
    [self emotionBtnDidClick:btn];
    //重设输入框
    [self resetTextStyle];
}

- (void)resetTextStyle {
    NSRange wholeRange = NSMakeRange(0, _IputView.textStorage.length);
    [_IputView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    [_IputView.textStorage addAttribute:NSFontAttributeName value:self.font range:wholeRange];
    [self.IputView scrollRectToVisible:CGRectMake(0, 0, _IputView.contentSize.width, _IputView.contentSize.height) animated:YES];
}

//删除按钮事件
- (void)deleteBtnClick:(UIButton *)btn {
    [self emotionBtnDidClick:btn];
    [self.IputView deleteBackward];
}

//scrollview代理事件，在这里处理pageControl;处理见键盘页面切换时候改变底部表情按钮的选中状态等
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.emojiBtn.selected) {
        self.pageControl.numberOfPages = 7;
        self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    }
}

//根据字体计算表情的高度
- (CGFloat)heightWithFont:(UIFont *)font {
    if (!font){font = [UIFont systemFontOfSize:17];}
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGSize maxsize = CGSizeMake(100, MAXFLOAT);
    CGSize size = [@"/" boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size.height;
}

- (void)emotionBtnDidClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(emotionView_sBtnDidClick:)]) {
        [self.delegate emotionView_sBtnDidClick:btn];
    }
}

//gif表情的事件
-(void)BtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(gifBtnClick:)]) {
        [self.delegate gifBtnClick:btn];
    }
}


//底部不同表情按钮的事件，用来处理键盘页面的切换，和scrollViewDidScroll处理的事件是相互的！（点按钮切换页面，滑动页面改变按钮选中状态）
- (void)emotionBtnsClick:(UIButton *)btn {
    self.emotionBtn.selected = NO;
    self.emotionBtn = btn;
    btn.selected = !btn.selected;
    CGPoint point = self.pageView.contentOffset;
    point.x = 0;
    self.pageView.contentOffset = point;
}
-(void)clickMoreWayBtn:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(MoreWayBtnDidClicked:)]) {
        [self.delegate MoreWayBtnDidClicked:sender];
    }
}

@end

