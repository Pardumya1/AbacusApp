import 'package:abacus_app/screens/student_screens/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../utils/screen.dart';


class PlayScreen extends StatefulWidget {

  static const String routeName = '/PlayScreen';
  final String levelStatus;
  final String levelId;
  final String name;

  const PlayScreen({super.key, required this.levelStatus, required this.levelId, required this.name});

  @override
  State<StatefulWidget> createState() => _PlayScreen();

}

class _PlayScreen extends State<PlayScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 10000 * 30;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "images/background.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light),
            title: Text(widget.name),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Image(
                  image: AssetImage("images/back.png"),
                  width: 14,
                  height: 14,
                  color: Colors.white,
                )),
            actions: [
              GestureDetector(
                  onTap: () {

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ScoreScreen()));

                  },
                  child: Card(
                      color: const Color(0x783f6098),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Container(
                          alignment: Alignment.center,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Image.asset(
                                    'images/clock_icon.png',
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CountdownTimer(
                                    endTime: endTime,
                                    textStyle: const TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: "Montserrat",
                                        color: Colors.white),
                                  )
                                )
                              ]))))
            ],
            titleTextStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: "Montserrat"),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: buildBody()),
    ]);
  }

  Widget buildBody() {
    return SizedBox(
        width: double.infinity,
        child: Stack(children: [
          const Image(image: AssetImage("images/home_bg.png"), fit: BoxFit.fill),
          showContent(),
        ]));
  }

  showAbacus(){
    return Container(
      margin: const EdgeInsets.only(left: 10,right: 10, top: 30),
      alignment: Alignment.center,
      height: SizeConfig.blockSizeVertical*35,
      width: SizeConfig.blockSizeHorizontal*180,
      child: InAppWebView(
        onWebViewCreated: (InAppWebViewController controller) {
          var uri = "assets/index.html";
          controller.loadFile(assetFilePath: uri);
        },
      ),

    );
  }

  showContent() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Row(
          children: [
            const Expanded(
                flex: 7,
                child: Text("Let’s input number to abacus",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16.0,
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600))),
            Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                    child: const Text("1/10",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 16.0,
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600))
                ))
          ],
        ),
      ),

          Expanded(child: SingleChildScrollView(

              scrollDirection: Axis.vertical,
              child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      image: DecorationImage(
                          image: AssetImage("images/background.png"),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [

                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF063464),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Container(
                                margin: const EdgeInsets.only(left: 5, right: 5, top :5 ),
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight:
                                        Radius.circular(20.0),
                                        topLeft:
                                        Radius.circular(20.0)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "images/background.png"),
                                        fit: BoxFit.cover)),
                                child: const Flexible(
                                    flex: 1,
                                    child: Text(
                                      "Calculate the following multiplication.",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Montserrat",
                                          color: Colors.black),
                                    )),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft:
                                        Radius.circular(20.0),
                                        bottomRight:
                                        Radius.circular(20.0)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "images/background.png"),
                                        fit: BoxFit.cover)),
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        height: 90,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "6 x 11 = ?",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Montserrat",
                                              color: Colors.black),
                                        ),
                                      ),
                                      /*Container(
                                    margin: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 20,
                                        bottom: 20),
                                    child: Row(

                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [

                                          Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF063464),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      5),
                                                ),
                                                height: 40,
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            right: 10),
                                                        child: Image.asset(
                                                          'images/reset_icon.png',
                                                          width: 14,
                                                          height: 14,
                                                          color: Colors.white,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      const Text(
                                                        "Reset Abacus",
                                                        style: TextStyle(
                                                            decoration:
                                                            TextDecoration
                                                                .none,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            fontFamily:
                                                            "Montserrat",
                                                            color:
                                                            Colors.white),
                                                      ),
                                                    ]),
                                              )),

                                          SizedBox(width: 30),

                                          Expanded(
                                              child: GestureDetector(
                                                  onTap: () {
                                                    showHintsAlert();
                                                  },
                                                  child: Container(
                                                    decoration:
                                                    BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: const Color(
                                                              0XFF29392A),
                                                          width:
                                                          1 // red as border color
                                                      ),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5),
                                                    ),
                                                    alignment:
                                                    Alignment.center,
                                                    height: 40,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                right:
                                                                10),
                                                            child: Image
                                                                .asset(
                                                              'images/hint_icon.png',
                                                              width: 14,
                                                              height: 20,
                                                              color: const Color(
                                                                  0xff29392a),
                                                              fit: BoxFit
                                                                  .fill,
                                                            ),
                                                          ),
                                                          const Text(
                                                            "Hints",
                                                            style: TextStyle(
                                                                decoration:
                                                                TextDecoration
                                                                    .none,
                                                                fontSize:
                                                                14,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                                fontFamily:
                                                                "Montserrat",
                                                                color: Color(
                                                                    0xff29392a)),
                                                          ),
                                                        ]),
                                                  )))

                                        ]),
                                  ),*/
                                    ]),
                              ),

                            ]),
                      ),

                      Container(

                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/background.png"),
                                fit: BoxFit.cover)),

                        height: SizeConfig.blockSizeVertical*45,
                        // width: SizeConfig.blockSizeHorizontal*180,
                        width: SizeConfig.blockSizeHorizontal*180,
                        margin: const EdgeInsets.only(left: 10,right: 10, top: 0),
                        child: InAppWebView(
                          initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                              supportZoom: false,
                            ),
                          ),

                          onWebViewCreated: (InAppWebViewController controller) {
                            var uri = "assets/index.html";
                            controller.loadFile(assetFilePath: uri);

                          },

                        ),

                      ),

                    ],
                  )) //.horizontal//apply padding to all four sides

          ),),

          Container(
            margin: const EdgeInsets.only(top: 20,bottom: 10, left: 20, right: 20),
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF063464),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: const BorderSide(color: Color(0xFF063464))),
                    elevation: 6.0
                ),
                onPressed: () {},
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white),
                )
            ),
          ),


        ],
      ),
    );
  }

  /*  showContent() {
    return SafeArea(
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                    flex: 7,
                    child: Text("Let’s input number to abacus",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 16.0,
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600)
                    )
                ),

                Expanded(
                    flex: 3,
                    child: Text("1/10",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 16.0,
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600)
                    )
                )
              ],
            ),
          ),

          Container(
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: new AssetImage("images/background.png"),
                      fit: BoxFit.cover)),

              child: Expanded(
                flex: 1,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0XFF3CA82E),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                Container(
                                  margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 10, right: 10),
                                              child: Text(
                                                "Lesson 3",
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Montserrat",
                                                    color: Colors.white),
                                              ),
                                              alignment: Alignment.center,
                                            )
                                        ),

                                        Expanded(
                                            flex: 7,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0XFFEFF9DF),
                                                borderRadius: new BorderRadius.only(
                                                  topRight: const Radius.circular(20.0),
                                                ),
                                              ),
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                "When the multiplicand is one digit.",
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Montserrat",
                                                    color: Colors.black),
                                              ),
                                            )
                                        )
                                      ]),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0XFFEFF9DF),
                                    border: Border(
                                      bottom:
                                      BorderSide(color: Colors.green, width: 1),
                                      top: BorderSide(color: Colors.green, width: 1),
                                    ),
                                  ),
                                  child: Row(

                                      children: [
                                        Expanded(
                                            flex: 7,
                                            child: Text(
                                              "Calculate the following multiplication.",
                                              style: TextStyle(
                                                  decoration: TextDecoration.none,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Montserrat",
                                                  color: Colors.black),
                                            )
                                        ),

                                        Expanded(flex: 3,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                padding: const EdgeInsets.all(5),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 5),
                                                        child: Image.asset(
                                                          'images/answer_icon.png',
                                                          width: 18,
                                                          height: 18,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Answer",
                                                        style: TextStyle(
                                                            decoration:
                                                            TextDecoration.none,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: "Montserrat",
                                                            color: Colors.black),
                                                      ),
                                                    ]
                                                )
                                            )
                                        )

                                      ]),
                                ),

                                Container(
                                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color(0XFFEFF9DF),
                                    borderRadius: new BorderRadius.only(bottomLeft: const Radius.circular(20.0), bottomRight: const Radius.circular(20.0)),
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                          height: 90,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "6 x 11 = ?",
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Montserrat",
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(0xff29392A),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      height: 40,
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 10),
                                                              child: Image.asset(
                                                                'images/reset_icon.png',
                                                                width: 14,
                                                                height: 14,
                                                                fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Reset Abacus",
                                                              style: TextStyle(
                                                                  decoration:
                                                                  TextDecoration.none,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontFamily:
                                                                  "Montserrat",
                                                                  color: Colors.white),
                                                            ),
                                                          ]),
                                                    )
                                                ),

                                                SizedBox(width: 30),

                                                Expanded(
                                                    child: GestureDetector(
                                                        onTap: (){
                                                          showHintsAlert();
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: Color(0XFF29392A),
                                                                width:
                                                                1 // red as border color
                                                            ),
                                                            borderRadius: BorderRadius.circular(5),
                                                          ),
                                                          alignment: Alignment.center,
                                                          height: 40,
                                                          child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Padding(padding: const EdgeInsets.only(right: 10),
                                                                  child: Image.asset(
                                                                    'images/hint_icon.png',
                                                                    width: 14,
                                                                    height: 20,
                                                                    fit: BoxFit.fill,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "Hints",
                                                                  style: TextStyle(
                                                                      decoration:
                                                                      TextDecoration.none,
                                                                      fontSize: 14,
                                                                      fontWeight:
                                                                      FontWeight.w600,
                                                                      fontFamily:
                                                                      "Montserrat",
                                                                      color: Color(0xff29392A)),
                                                                ),
                                                              ]
                                                          ),
                                                        )
                                                    )
                                                )

                                              ]),
                                        ),
                                      ]),
                                ),
                              ]),
                        ),

                        // showAbacus()

                      ],
                    )
                  )
              )

          )
        ],
      )),
    );
  }*/

  showHintsAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 0.0,
            ),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 24),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 30),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF504444),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
