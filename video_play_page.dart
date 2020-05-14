import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';

/// 视频播放页面
/// zwb
/// 2020-05-14
/// 播放器插件的使用封装 awsome_video_player: ^1.0.8+1
class VideoPlayPage extends StatefulWidget {
  String dataSource;/// 数据源 url地址 或 file地址
  Widget appBar; /// appbar 自定义
  Colors backColor; /// 背景色
  VideoTopBarStyle videoTopBarStyle; /// 播放器top自定义
  VideoControlBarStyle videoControlBarStyle; /// 进度条自定义
//  VideoSubtitles videoSubtitlesStyle;
//  VideoLoadingStyle videoLoadingStyle;

  VideoPlayPage({this.dataSource,this.backColor,this.appBar,this.videoControlBarStyle,this.videoTopBarStyle});
  @override
  _VideoPlayPageState createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  String netText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backColor ?? Colors.black,
      appBar:widget.appBar ?? AppBar(
        centerTitle: true,
        title:  Text('视频播放'),
      ),
      body: Center(
        child: AwsomeVideoPlayer(
          widget.dataSource ?? "http://mvdown.kuwo.cn/1cbe341e5973485d50635e9afeb1851b/5ebd652e/resource/m1/58/94/2448472021.mp4",
//          "http://win.web.rc03.sycdn.kuwo.cn/70e7ab376be7cd4d92024fb38f3053cd/5ebd6424/resource/m3/47/12/1765786525.mp4",
//          "http://win.web.rd03.sycdn.kuwo.cn/d66478381c8dc9c76793bd56280736f8/5ebd63ce/resource/m1/1/89/3157702758.mp4",
//          "http://mvdown.kuwo.cn/d5536bd1bca8631490959f6003c9eafc/5ebd6341/resource/m2/1/30/475918289.mp4",
//          "http://sr.sycdn.kuwo.cn/081daa6ea723d89a76cd8556d5b1fa62/5ebd627c/resource/m1/80/67/3041072076.mp4",
          /// 监听网络
          onnetwork: (v){
            debugPrint("网络："+v??"");
            setState(() {
              netText = v??"";
            });
          },
          /// 视频播放配置
          playOptions: VideoPlayOptions(
              /// 快进3秒
              seekSeconds: 3,
              loop: true,
              autoplay: true,
              allowScrubbing: true,
              startPosition: Duration(seconds: 0),
          ),
          /// 自定义视频样式
          videoStyle: VideoStyle(
            videoTopBarStyle:widget.videoTopBarStyle ?? VideoTopBarStyle(
              popIcon: SizedBox(),
              actions: [
                Text("当前网络：${netText}",style: TextStyle(color: Colors.white,fontSize: 12),),
              ]
            ),
            /// 自定义底部控制栏
            videoControlBarStyle:widget.videoControlBarStyle ?? VideoControlBarStyle(
              height: 45,
              /// 更改进度栏的播放按钮
              playIcon: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 25
              ),
              /// 更改进度栏的暂停按钮
              pauseIcon: Padding(padding: EdgeInsets.only(left: 5,right: 5),
                child: Icon(
                  Icons.pause,
                  color: Colors.blue,
                  size: 25,
                ),
              ),
              /// 更改进度栏的全屏按钮
              fullscreenIcon: Icon(
                Icons.fullscreen,
                size: 25,
                color: Colors.white,
              ),
              /// 更改进度栏的退出全屏按钮
              fullscreenExitIcon: Icon(
                Icons.fullscreen_exit,
                size: 25,
                color: Colors.blue,
              ),
              /// 更改进度栏的快退按钮
              rewindIcon: SizedBox(),
              /// 更改进度栏的快进按钮
              forwardIcon: SizedBox(),
              /// 更改进度栏的颜色
              progressStyle: VideoProgressStyle(
                /// 已播放
                playedColor: Colors.blue
              )
            ),
          ),
        ),
      ),
    );
  }
}
