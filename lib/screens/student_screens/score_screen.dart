import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ScoreScreen extends StatefulWidget {
  static const String routeName = '/ScoreScreen';

  @override
  State<StatefulWidget> createState() => _ScoreScreen();
}

class _ScoreScreen extends State<ScoreScreen> {
  List<String> countries = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Image.asset(
            "images/background.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.light
                ),
                title: const Text("Level 1"),
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
                      color: Colors.white,
                      //fit: BoxFit.fill,
                    ),
                  ),

                ),

                titleTextStyle: TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: "Montserrat"),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body:  buildBody()
          ),
        ]

    );
  }

  Widget buildBody() {
    return SizedBox(
        width: double.infinity,

        child: Stack(
            children: [
              Image(
                  image: new AssetImage("images/home_bg.png"),
                  fit: BoxFit.fill),

              showContent()

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

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(
                   flex: 5,
                    child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Text("Results",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 16.0,
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600))
                  )
                ),

              Expanded(
                  flex: 5,
                  child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Text("Score : 30",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 16.0,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600))))

            ]
          ),

          Expanded(
            flex: 1,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,//Radius.circular(20)
                        ),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        image: DecorationImage(
                            image: new AssetImage("images/background.png"),
                            fit: BoxFit.fill
                        )
                    ),

                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CircularPercentIndicator(
                                radius: 100.0,
                                lineWidth: 25.0,
                                percent: 0.6,
                                center: const Text("60%",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Montserrat",
                                        color: Colors.black)),
                                backgroundColor: Color(0x31063464),
                                progressColor: Color(0xFF063464),
                              ),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Container(child: const Text("Correct Answer 60%",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Montserrat",
                                          color: Colors.black)),),

                                  Container(
                                    margin:
                                    EdgeInsets.only(bottom: 8, top: 8, left: 5),
                                    child: const Text("Wrong Answer 30%",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Montserrat",
                                            color: Colors.black)),),

                                  Container(child: const Text("Missed Questions 10%",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Montserrat",
                                          color: Colors.black)),)


                                ]),

                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 40),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(0x735CC15C),
                                        width: 1 // red as border color
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: countries.map((country) {
                                      return Container(
                                          height: 115,
                                          width: 60,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                  width: 1.0,
                                                  color: Color(0x735CC15C)),
                                            ),
                                          ),
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  width: 60,
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets.only(
                                                      bottom: 20, top: 20),
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                          width: 1.0,
                                                          color:
                                                          Color(0x735CC15C)),
                                                    ),
                                                  ),
                                                  child: Text(country,
                                                      style: const TextStyle(
                                                          decoration:
                                                          TextDecoration.none,
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontFamily:
                                                          "Montserrat",
                                                          color: Colors.black)),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15, top: 15),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ]));
                                    }).toList(),
                                  ),
                                )),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 0, right: 20, top: 40),
                              alignment: Alignment.center,
                              child: const Text(
                                "Try Wrong Question!",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat",
                                    color: Color(0xff29392a)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 30, left: 10, right: 10, bottom: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0, right: 20),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 1 // red as border color
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 40,
                                          right: 40,
                                          bottom: 10),
                                      child: const Text(
                                        "Retry",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Montserrat",
                                            color: Color(0xff29392a)),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xff063464),
                                        border: Border.all(
                                            color: Color(0xff063464),
                                            width: 1 // red as border color
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 20, right: 0),
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 40,
                                          right: 40,
                                          bottom: 10),
                                      height: 40,
                                      child: const Text(
                                        "Exit",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Montserrat",
                                            color: Colors.white),
                                      ),
                                    ),
                                  ]),
                            ),
                          ]),
                    )

                )//.horizontal//apply padding to all four sides

            ),

          ),

        ],
      )),
    );
  }
}
