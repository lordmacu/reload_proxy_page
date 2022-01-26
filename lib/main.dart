// @dart=2.9
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:async';
import 'package:wakelock/wakelock.dart';
import 'dart:collection';

import 'package:toast/toast.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

// import 'dart:convert';
import 'dart:io';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Refresher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'BankSocial Refresh'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Timer _timerForInter;
  Timer _timerForInterTwo;
  InAppWebViewController webViewController;
  int counter=0;
  String from;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 80;


  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(

      crossPlatform: InAppWebViewOptions(


      ),
      android: AndroidInAppWebViewOptions(
        geolocationEnabled: true,
        hardwareAcceleration: true,

        clearSessionCache: true,
        cacheMode: AndroidCacheMode.LOAD_NO_CACHE,
        loadWithOverviewMode: true,
        thirdPartyCookiesEnabled: false,



      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  int randomNumber;
  String tempUrl;

  @override
  void initState() {

    Wakelock.enable();
    _timerForInter = Timer.periodic(Duration(seconds: 80), (result) {
      crockProxy();

    });


    super.initState();
  }


  proxyscrape(){
    String url="https://www.croxyproxy.com/_es/servers";

    var random = new Random();

    randomNumber=random.nextInt(100);
    setState(() {
      tempUrl="${url}?rand=${randomNumber}";
    });




    var postData = Uint8List.fromList(utf8.encode("url=https://www.top10vpn.com/tools/what-is-my-ip/"));
    //var postData = Uint8List.fromList(utf8.encode("url=https://www.dextools.io/app/uniswap/pair-explorer/0x6a0d8a35cda1f0d3534a346394661ed02e9a4072"));

    print("aquii esta mano ${tempUrl}");
    webViewController.postUrl(url:Uri.parse(tempUrl), postData: postData);
    counter=counter+1;

    print("este es ---- proxyscrepe");

  }


  crockProxy(){
    String url="https://www.croxyproxy.com/_es/servers";

    var random = new Random();

    randomNumber=random.nextInt(100);
    setState(() {
      tempUrl="${url}?rand=${randomNumber}";
    });

    var postData = Uint8List.fromList(utf8.encode("url=https://www.binance.com/es/nft/goods/detail?nftInfoId=12985342&isProduct=1"));

    webViewController.postUrl(url:Uri.parse(tempUrl), postData: postData);

    print("otroooo ${tempUrl}");

    counter=counter+1;

    print("este es ----  crockproxy");

    setState(() {
      endTime=DateTime.now().millisecondsSinceEpoch + 1000 * 80;
    });

  }


  @override
  void dispose() {
    // Add these to dispose to cancel timer when user leaves the app
    _timerForInter.cancel();
    _timerForInterTwo.cancel();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.title,style: TextStyle(color: Color(0xff111f39)),),
          actions: <Widget>[


            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    _timerForInter.cancel();
                    _timerForInterTwo.cancel();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage(title:  'BankSocial Refresh',)),
                    );

                  },
                  child: Icon(
                    Icons.refresh,color:  Color(0xff111f39),
                  ),
                )
            ),
          ],
        ),
        body: Column(
          children: [
            Container(

                padding: EdgeInsets.only(right: 20.0,top: 5,bottom: 5),
                child:  CountdownTimer(
                  endTime: endTime,

                  textStyle: TextStyle(color: Colors.redAccent),
                  widgetBuilder: (_, time) {
                    if (time == null) {
                      return Text('0');
                    }
                    return Text(
                      'AutoRefresh in: ${time.sec}',style: TextStyle(fontSize: 16),);
                  },

                )
            ),
            Expanded(child: InAppWebView(

              initialOptions: options,


            //  initialUrl: "https://www.binance.com/es/nft/goods/detail?nftInfoId=12482302&isProduct=1",


              onWebViewCreated: (controller) {
                webViewController=controller;
                crockProxy();

              },
              onPageCommitVisible: (controller,url) {
                print("eta ess la url ${url} ");
                Toast.show("Commit: ${url}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
              },
              onLoadStop: (controller,url) {
                print("eta ess la url ${url} ");

                Toast.show("LoadStop: ${url}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);


              },

              onUpdateVisitedHistory: (controller,url,android) {
                print("eta ess la url ${url} ");

                Toast.show("From: ${url}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

              },

            ))
          ],
        )
    );
  }
}
