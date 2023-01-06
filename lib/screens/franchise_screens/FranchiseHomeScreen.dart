import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../marge_screens/landing_screen.dart';

class FranchiseHomeScreen extends StatefulWidget {
  static const String routeName = '/FranchiseHomeScreen';

  const FranchiseHomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FranchiseHomeScreen();
}

class _FranchiseHomeScreen extends State<FranchiseHomeScreen>
    with WidgetsBindingObserver {


  double progress = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey webViewKey = GlobalKey();
  late InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "https://abacus.mytura.in/franchiseelogin";


  @override
  void initState() {

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController.reload();
        } else if (Platform.isIOS) {
          webViewController.loadUrl(
              urlRequest: URLRequest(url: await webViewController.getUrl()));
        }
      },
    );

    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark));

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark));
    } else if (state == AppLifecycleState.paused) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    return buildBody();
  }

  Widget buildBody() {
    return WillPopScope(
        onWillPop: () => _exitApp(context),
        child: Scaffold(
            // extendBodyBehindAppBar: true,
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            body: Column(children: <Widget>[
              /*     Toolbar View      */
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Image.asset(
                              "images/logo.png",
                              width: 60,
                              height: 60,
                            )),
                        // Container(
                        //     margin: const EdgeInsets.only(bottom: 5, left: 5),
                        //     child: const Text(
                        //       "Dashboard",
                        //       style: TextStyle(
                        //           decoration: TextDecoration.none,
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.bold,
                        //           fontFamily: "Montserrat",
                        //           color: Colors.black),
                        //     )),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Landing()),
                        );
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              margin: const EdgeInsets.only(right: 5, top: 10),
                              child: const Image(
                                image: AssetImage("images/menu_logout.png"),
                                height: 24,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    top: 15, bottom: 5, right: 10),
                                child: const Text(
                                  "Exit",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat",
                                      color: Colors.black),
                                )),
                          ]),
                    )
                  ],
                ),
              ),

              Container(
                  padding: EdgeInsets.all(10.0),
                  child: progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container()),

              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(url),
                    ),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (InAppWebViewController controller) {
                      webViewController = controller;
                    },
                    onReceivedServerTrustAuthRequest:
                        (controller, challenge) async {
                      return ServerTrustAuthResponse(
                          action: ServerTrustAuthResponseAction.PROCEED);
                    },

                    onLoadStart: (controller, url) {
                      // pullToRefreshController.beginRefreshing();
                    },

                    onProgressChanged: (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                      }
                    },


                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;

                      if (![
                        "http",
                        "https",
                        "file",
                        "chrome",
                        "data",
                        "javascript",
                        "about"
                      ].contains(uri.scheme)) {
                        if (await canLaunchUrl(Uri.parse(url))) {
                          // Launch the App
                          await launchUrl(
                            Uri.parse(url),
                          );
                          // and cancel the request
                          return NavigationActionPolicy.CANCEL;
                        }
                      }

                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) async {
                      pullToRefreshController.endRefreshing();
                    },
                    onLoadError: (controller, url, code, message) {
                      pullToRefreshController.endRefreshing();
                    },

                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      // setState(() {
                      //   this.url = url.toString();
                      //   urlController.text = this.url;
                      // });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      print(consoleMessage);
                    },

                  ) //Container
                  ),
            ])));
  }

  Future<bool> _exitApp(BuildContext context) async {
    var value = await webViewController.canGoBack();
    print("Click$value");

    webViewController.goBack();

    if (await webViewController.canGoBack()) {
      print("Click IN");
      print("onwill goback");
      webViewController.goBack();
      return Future.value(true);
    } else {
      print("Click OUT");
      print("No back history item");
      // Scaffold.of(context).showSnackBar(
      //   const SnackBar(content: Text("No back history item")),
      // );
      return Future.value(false);
    }
  }

}
