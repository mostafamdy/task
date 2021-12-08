import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:video_player/video_player.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math' as math;
import 'banner.dart'as bannerModel;
//-d chrome --web-port 55555 --web-hostname 127.0.0.1

void main() {
  runApp(MyApp());
}


//class BannerTest extends StatefulWidget {
//  @override
//  _BannerTestState createState() => _BannerTestState();
//}
//
//class _BannerTestState extends State<BannerTest> {
//
//  @override
//  void initState() {
////    Banner().getBanners();
//     bannerModel.Banner banner=bannerModel.Banner()..getBanners();
//     print("banner createdAt ${banner.createdAt}");
//     super.initState();
//
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//
//
//}
//
//class TimeCountDown extends StatefulWidget {
//  @override
//  _TimeCountDownState createState() => _TimeCountDownState();
//}
//
//class _TimeCountDownState extends State<TimeCountDown> {
//  int min=1;
//  int seconds=60;
//  double textSize=20;
//  @override
//  Widget build(BuildContext context) {
//    if(min>=0){
//    Future.delayed(Duration(seconds: 1)).then((value) {
//      print("value ${value.toString()}");
//      seconds=seconds-1;
//      print("seconds "+seconds.toString());
//      if(seconds==-1){
//        seconds=60;
//        min=min-1;
//        if(min<0){
//          seconds=0;
//        }
//      }
//      setState(() {});
//    });
//    }
//    return Center(
//          child: UnconstrainedBox(
//            child: Container(
//              color: Colors.amber,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Text("Time remaining",style: TextStyle(fontSize: textSize,fontWeight: FontWeight.bold),),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Text("0${min==-1?0:min}:${seconds}",style: TextStyle(fontSize: textSize,fontWeight: FontWeight.bold),),
//                  )
//                ],
//              ),
//            ),
//          ),
//        )
//    ;
//  }
//
//  @override
//  void initState() {
//
//  }
//}
//

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  FlutterLocalNotificationsPlugin fltrNotification = FlutterLocalNotificationsPlugin();
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  List<Media> mediaList=[];
  int turn=0;
  @override
  void initState() {
    mediaList.add(Media(path: 'assets/1_off.jpg',type:  MediaType.image,createdAt: 0,duration: 1));
    mediaList.add(Media(path: 'assets/2.mp4',type:  MediaType.video,createdAt: 2,duration: 2));
    mediaList.add(Media(path: 'assets/2_off.jpg', type: MediaType.image,createdAt: 3,duration: 1));
    mediaList.add(Media(path: 'assets/3_on.jpg', type: MediaType.image,createdAt: 4,duration: 1));
    mediaList.add(Media(path: 'assets/4_on2.jpg',type:  MediaType.image,createdAt: 5,duration: 1));
    mediaList.add(Media(path: 'assets/5_on.png', type: MediaType.image,createdAt: 6,duration: 2));
    mediaList.add(Media(path: 'assets/1.mp4', type: MediaType.video,createdAt: 1,duration: 8));
    mediaList=Media.sortWithCreated(mediaList);

//    ________________________________________________________________________________________
//    var androidInitilize = new AndroidInitializationSettings('app_icon');
//    var initilizationsSettings = new InitializationSettings(android: androidInitilize);
//    fltrNotification.initialize(initilizationsSettings, onSelectNotification: selectNotification);

//    showNotification();
//    ________________________________________________________________________________________

//    showScheduledNotfication(DateTime.now().add(Duration(seconds: 30)));
//    showScheduledNotfication(DateTime.now().add(Duration(seconds: 31)));
//    showScheduledNotfication(DateTime.now().add(Duration(seconds: 32)));
//    showScheduledNotfication(DateTime.now().add(Duration(seconds: 33)));
//    showScheduledNotfication(DateTime.now().add(Duration(seconds: 34)));
//    showScheduledNotfication(DateTime.now().add(Duration(seconds: 35)));

    super.initState();
  }

  double firstX=0;
  double lastX=0;
  Timer? t;

  @override
  Widget build(BuildContext context) {

    if(mediaList[turn].type==MediaType.image){
      t=Timer(Duration(seconds: mediaList[turn].duration*5),(){
        turn=turn+1;
        if(turn==mediaList.length){
          turn=0;
        }
        if(mediaList[turn].type==MediaType.video){
          _controller=VideoPlayerController.asset(mediaList[turn].path)..play()..setLooping(true);
          _initializeVideoPlayerFuture=_controller.initialize();
        }
        setState(() {});
      });
    }
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onHorizontalDragStart: (detatils){
//              print("start horizontal drag");
              firstX=detatils.globalPosition.dx;
              },
            onHorizontalDragUpdate: (detals){
              lastX=detals.globalPosition.dx;
//              print("update lastx $lastX");
            },
            onHorizontalDragEnd: (details){
//              print("lastX $lastX");
//              print("firstX $firstX");
//              print("directon ${lastX>firstX}");
              if(lastX>firstX){
                turn=turn+1;
              }
              if(lastX<firstX){
                turn=turn-1;
              }
              if(turn==mediaList.length){
                turn=0;
              }
              if(turn==-1){
                turn=mediaList.length-1;
              }
//              print("turn $turn");
              firstX=0;
              lastX=0;
              t!.cancel();
              if(mediaList[turn].type==MediaType.video){
                _controller=VideoPlayerController.asset(mediaList[turn].path)..play()..setLooping(true);
                _initializeVideoPlayerFuture=_controller.initialize();
              }
              setState(() {});
            },
            child: Container(
              child: mediaList[turn].type==MediaType.image
                  ? Image.asset(mediaList[turn].path)
                  : FutureBuilder(
                     future: _initializeVideoPlayerFuture,
                     builder:(c,snap){
                     if(snap.connectionState==ConnectionState.done){
                      t=Timer(Duration(seconds:  mediaList[turn].duration*10),
                              (){
                                _controller.dispose();
                                turn=turn+1;
                                if (turn==mediaList.length){
                                  turn=0;
                                }
                                if(mediaList[turn].type==MediaType.video){
                                  _controller=VideoPlayerController.asset(mediaList[turn].path)..play()..setLooping(true);
                                  _initializeVideoPlayerFuture=_controller.initialize();
                                }
                                setState(() {});
                              });
                      return VideoPlayer(_controller);
                    }
                     else{
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                     }),
            ),
          ),
        ),
      ),
    );
  }
//  Future showNotification() async {
//    var androidDetails = const AndroidNotificationDetails("ChannelID"," channel Name");
//    var generalNotificationDetails = NotificationDetails(android: androidDetails);
//
//    await fltrNotification.show(
//        0, "Task", "You created a Task",
//        generalNotificationDetails, payload: "Task");
//  }
//
//  Future<void> selectNotification(String? payload) async {
//    if (payload != null) {
//      debugPrint('notification payload: $payload');
//    }
//    print("notfication pressed");
////    await Navigator.push(
////      context,
////      MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
////    );
//  }
//
//  void showScheduledNotfication(DateTime createdAt) async {
//    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
////
//    tz.initializeTimeZones();
//    print("current time zone");
//    print(currentTimeZone);
////    tz.setLocalLocation(tz.getLocation(currentTimeZone));
//    var androidDetails = const AndroidNotificationDetails("ChannelID"," channel Name");
//    var generalNotificationDetails = NotificationDetails(android: androidDetails);
//    fltrNotification.zonedSchedule(1,
//      "title",
//      "body",
//      tz.TZDateTime.from(createdAt,tz.local),
//      generalNotificationDetails,
//      androidAllowWhileIdle: true,
//      uiLocalNotificationDateInterpretation:UILocalNotificationDateInterpretation.absoluteTime ,
//    );
//  }
}


class Media{
  String path;
  MediaType type;
  int duration;
  int createdAt;
  Media({required this.path,required this.type,required this.duration,required this.createdAt});

  static List<Media> sortWithCreated(List<Media> unsortedList){
    List<Media> sortedList =[];
    // selection sort
    // search for min value
    while(unsortedList.isNotEmpty) {
      Media min = unsortedList[0];
      int removedIndex = 0;
      for (int i = 0; i < unsortedList.length; i++) {
        if (unsortedList[i].createdAt < min.createdAt) {
          min = unsortedList[i];
          removedIndex = i;
        }
      }
      sortedList.add(min);
      unsortedList.removeAt(removedIndex);
    }
    print(sortedList);
    return sortedList;
  }
}
enum MediaType{
  image,video
}
//
//
