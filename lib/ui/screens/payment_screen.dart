import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import 'package:qawafel/constants.dart';
import 'package:qawafel/repository/userRepo.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final TabController controller;

  const PaymentScreen({Key key, this.controller}) : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String url;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
      child: ListView(
        shrinkWrap: true,
        children: [
          url == null
              ? Container()
              : Container(
                  height: ScreenUtil().setHeight(500),
                  child: WebView(
                    initialUrl: url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    debuggingEnabled: true,
                    javascriptChannels: <JavascriptChannel>{
                      _toasterJavascriptChannel(context),
                    },
                    navigationDelegate: (NavigationRequest request) {
                      if (request.url.startsWith('https://www.youtube.com/')) {
                        print('blocking navigation to $request}');
                        return NavigationDecision.prevent;
                      }
                      print('allowing navigation to $request');
                      return NavigationDecision.navigate;
                    },
                    onPageStarted: (String url) {
                      print('Page started loading: $url');
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                    },
                    gestureNavigationEnabled: true,
                  )),
          /*
          SizedBox(
            height: ScreenUtil().setHeight(5),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(18),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                ScreenUtil().setWidth(11)),
            child: Container(
              height: ScreenUtil().setHeight(44),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10.0),
                color: const Color(0xffffffff),
                border: Border.all(
                    width: 0.2,
                    color: const Color(0xff000000)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(11),
                  ),
                  Image.asset("assets/master.png"),
                  SizedBox(
                    width: ScreenUtil().setWidth(22),
                  ),
                  Text("Discover Pay")
                ],
              ),
            ),
          ),

           */
          SizedBox(
            height: ScreenUtil().setHeight(22),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(83)),
            child: buttonWidget("Confirm", Theme.of(context).primaryColor,
                Theme.of(context).primaryColor, Colors.white, () async {
              url = await UserRepo(context).inVoice(kUser.userId);
              setState(() {});
            }),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(27),
          ),
        ],
      ),
    );
  }

  Widget buttonWidget(
      String text, Color color, Color border, Color textColor, Function f) {
    return InkWell(
      onTap: f,
      child: Container(
        height: ScreenUtil().setHeight(31),
        width: ScreenUtil().setWidth(209),
        decoration: BoxDecoration(
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4)),
          color: color,
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: textColor,
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
