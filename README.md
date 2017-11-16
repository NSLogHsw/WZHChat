# WZHChat

# 简介
此demo为微信聊天界面，基于 Objective-C 语言及 MVC 框架实现。

有什么问题可以跟我交流，本人QQ：905640505，顺便求⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️~（网页右上角：🌟Star）

# 实现功能
1. 聊天（主人A与客人B聊天框随机分配，后期可根据接口调配）
2. 输入框实现表情展示
3. 本demo基本功能完善，后期会添加更多功能，敬请期待
4. 工程计划：<p>一期：至10月25日（已完成基本功能，语音有问题，撤回删除下拉加载还没有做，将在二期完成）</p>
                     <p>二期上：至11月15日（已解决语音功能、剔除相同时间加载，优化代码格式。下拉加载历史做了一半）</p>
                     <p>二期下：至2017年12月初（敬请期待，期间将解决语音播放动画、撤回删除复制转发）</p>
                     <p>三期：至2017年年底（敬请期待，增添视频功能，gif图片播放）</p>

# 项目演示
http://wx3.sinaimg.cn/large/005OnOYcly1fkvlscvkzjg308w0frx6w.gif


# Android语音适配问题
<p>项目在聊天时，Android 发送的语音格式为Android默认的 amr 格式，iOS 发送的格式为iOS默认的 wav 格式转 amr 格式(iOS优先为Android适配，原因是wav文件比较大，amr文件小，传送速度快)。</p>
<p>Android 接收到 iOS 发送的语音，原则上播放没有问题；iOS 接收到 Android 发送的语音，可能会出现两种情况：</p>
<p>1. 播放有杂音；</p>
<p>2. 不能播放，原因是 Android 所发送的语音虽然是 amr 格式，其实是 MPEG-4 格式，可以下载下载 mediainfo for Mac ，对比录制的 amr 参数是否一致。</p>
<p>以上两种情况，极大可能是因为 Android 中 MediaRecorder 的录制参数有问题以及输出文件格式设置错误，所以只要将 MediaRecorder 的音频设置，设置为 AMR 即可。</p>

<p>Android 端相关参考代码：</p>

```objc
// 设置所录制的声音的采样率。
mMediaRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
//设置音频文件的编码：AAC/AMR_NB/AMR_MB/Default 声音的（波形）的采样
mMediaRecorder.setOutputFormat(MediaRecorder.OutputFormat.AMR_NB);
// 设置输出文件的格式：THREE_GPP/MPEG-4/RAW_AMR/Default THREE_GPP(3gp格式，H263视频/ARM音频编码)、MPEG-4、RAW_AMR(只支持音频且音频编码要求为AMR_NB)
mMediaRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AMR_NB);
// 文件保存地址及名字
targetFile = new File(targetDir, targetName);
//设置输出文件的路径
mMediaRecorder.setOutputFile(targetFile.getPath());
// 设置录制的音频通道数
mMediaRecorder.setAudioChannels(1);
// 设置所录制的声音的采样率。
mMediaRecorder.setAudioSamplingRate(8000);
// 设置所录制的声音的编码位率。
mMediaRecorder.setAudioEncodingBitRate(64);
```


# 部分截图
![](http://wx4.sinaimg.cn/mw1024/005OnOYcly1fkvlrsptu6j30yi1pcasq.jpg) ![](http://wx4.sinaimg.cn/mw1024/005OnOYcly1fkvlrmzsvjj30yi1pc7f9.jpg)
![](http://wx4.sinaimg.cn/mw1024/005OnOYcly1fkvlrs107ej30yi1pc1i1.jpg) ![](http://wx4.sinaimg.cn/mw1024/005OnOYcly1fkvlrs53mfj30yi1pctps.jpg)![](http://wx2.sinaimg.cn/mw1024/005OnOYcly1fkvlrz56ufj30yi1pcqv6.jpg)![](http://wx1.sinaimg.cn/mw1024/005OnOYcly1fkvlrvjpqkj30yi1pckjl.jpg)![](http://wx3.sinaimg.cn/mw1024/005OnOYcly1fkvlrsb6xjj30yi1pc7j9.jpg)

