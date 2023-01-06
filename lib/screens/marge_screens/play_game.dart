
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Game extends StatefulWidget {
  static const String routeName = '/Game';

  const Game({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Game();
}

class _Game extends State<Game> {

  WebViewController? _webViewController;

  @override
  void initState() {

    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

  }

  @override
  dispose() {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[

        Image.asset(
          "images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),

        Scaffold(

          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark),
            title: const Text('Virtual Abacus'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'images/back.png',
                  width: 14,
                  height: 14,
                  // fit: BoxFit.fill,
                ),
              ),
            ),
            titleTextStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF47473F),
                fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
          ),

          body: SizedBox(
            height: double.infinity,
            width: double.infinity,

            /*child: InAppWebView(
                onWebViewCreated:
                    (InAppWebViewController controller) {
                  var uri = "assets/index.html";
                  controller.loadFile(assetFilePath: uri);
                },

                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      supportZoom: false,
                      javaScriptEnabled: true,
                      preferredContentMode: UserPreferredContentMode.MOBILE),
                )),*/

            child: WebView(
              initialUrl: 'about:blank',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) async {
                _webViewController = webViewController;
                String fileContent = await rootBundle.loadString('assets/index.html');
                _webViewController?.loadUrl(Uri.dataFromString(fileContent, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
              },
              zoomEnabled: false,
              javascriptChannels: <JavascriptChannel>{
                JavascriptChannel(
                  name: 'messageHandler',
                  onMessageReceived: (JavascriptMessage message) {
                    print("message from the web view=\"${message.message}\"");
                  },
                )
              },

            ),


          ),
        )

      ],
    );

  }

}



