import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayScreenType2 extends StatefulWidget {
  static const String routeName = '/PlayScreenType2';

  @override
  State<StatefulWidget> createState() => _PlayScreenType2();
}

class _PlayScreenType2 extends State<PlayScreenType2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark
          //color set to transperent or set your own color
        )
    );

    super.dispose();
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
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light),
            title: const Text("Level 1"),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  child: Image(
                    image: new AssetImage("images/back.png"),
                    width: 14,
                    height: 14,
                    color: Colors.white,
                  ),
                )),
            actions: [
              Card(
                  color: Color(0x783f6098),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  margin: EdgeInsets.all(10),
                  child: Container(
                      alignment: Alignment.center,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:EdgeInsets.only(left: 10, right: 10),
                              child: Image.asset(
                                'images/clock_icon.png',
                                width: 16,
                                height: 16,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text("10:00",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600)),
                            )
                          ])))
            ],
            titleTextStyle: TextStyle(
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

        child: Stack(
            children: [
              Image(
                  image: new AssetImage("images/home_bg.png"),
                  fit: BoxFit.fill),

              showContent(),
              // showAbacus()

            ]

        )

    );
  }

  showContent() {
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

                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: new AssetImage("images/background.png"),
                      fit: BoxFit.cover)),

              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF063464),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                        padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.only(
                              topRight: const Radius.circular(20.0),
                              topLeft: const Radius.circular(20.0)
                            ),
                              image: DecorationImage(
                                  image: new AssetImage("images/background.png"),
                                  fit: BoxFit.cover)
                          ),
                        child: Row(

                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Text(
                                    "Input the number below",
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
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xff29392a),
                                            width: 1
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.only(right: 5, left: 5, top: 10, bottom: 10),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 5),
                                              child: Image.asset(
                                                'images/answer_icon.png',
                                                width: 18,
                                                height: 18,
                                                color: Color(0xff29392a),
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
                                                  color: Color(0xff29392a),
                                            ),
                                            )
                                          ]
                                      )
                                  )
                              )

                            ]),
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 2),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(bottomLeft: const Radius.circular(20.0), bottomRight: const Radius.circular(20.0)),
                            image: DecorationImage(
                                image: new AssetImage("images/background.png"),
                                fit: BoxFit.cover)
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                height: 200,
                                alignment: Alignment.center,


                              ),

                            ]),
                      ),
                    ]),
              )
          ),

          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff063464),
                          border: Border.all(
                              color: Color(0xff063464),
                              width: 1 // red as border color
                          ),
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
                                  color: Color(0xffffffff),
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
                                    fontFamily: "Montserrat",
                                    color: Color(0xffffffff)),
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
                              color: Color(0xffffffff),
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

          Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 30),
              padding: const EdgeInsets.only(left: 10, right: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Color(0xffbcbcbc),
                    width: 1 // red as border color
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                      flex: 8,
                      child: new TextField(
                          style: TextStyle(fontFamily: "Montserrat"),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintText: "Enter a Value",
                            hintStyle: TextStyle(
                                color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat"),
                          )
                      ),
                    ),

                    new Expanded(
                        flex: 2,
                        child: Container(
                            height: 45,
                        decoration: BoxDecoration(
                        color: Color(0xFF063464),
                          borderRadius: new BorderRadius.only(topRight: const Radius.circular(5.0), bottomRight: const Radius.circular(5.0)),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Image.asset(
                                'images/answer_icon.png',
                                width: 18,
                                height: 18,
                                color: Colors.white,
                                fit: BoxFit.fill,
                              ),
                            )
                          ]
                      )
                  )
    )

                  ]))

        ],
      )),
    );
  }

  showHintsAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(top: 0.0,),
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
                          icon: new Icon(Icons.close, size: 24),
                          onPressed: () { Navigator.pop(context); },
                        )
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 30),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF504444),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500
                        ),
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
