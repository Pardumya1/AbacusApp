import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CompetitioonResult extends StatefulWidget {
  static const String routeName = '/CompetitioonResult';

  @override
  State<StatefulWidget> createState() => _CompetitioonResult();
}

class _CompetitioonResult extends State<CompetitioonResult> {
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
    "10",
    "11",
    "12"
  ];

  @override
  void initState() {
    super.initState();
  }

  final List<Map> levels =
      List.generate(10, (index) => {"id": index, "name": "Level $index"})
          .toList();

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
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.light
                ),
                title: const Text("Level 1 Competition"),
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

  /*  Normal User */
  user_image() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 40),
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFF3A513B),
                child: Padding(
                  padding: const EdgeInsets.all(4), // Border radius
                  child: ClipOval(child: Image.asset('images/user_image.png')),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: const Text("Anurag",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16.0,
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600)),
              )
            ]));
  }

  /*  winner User  */
  winner_user_image() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 40),
        alignment: Alignment.center,
        child: Stack(
            children: <Widget>[

              Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Color(0xFF3A513B),
                      child: Padding(
                        padding: const EdgeInsets.all(4), // Border radius
                        child: ClipOval(child: Image.asset('images/user_image.png')),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      child: const Text("James",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 16.0,
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600)),
                    )
                  ]
              ),


              Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: Image.asset('images/win_trophy.png', width: 30, height: 30,)
              )

            ]));
  }

  showContenth() {
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
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,//Radius.circular(20)
                            ),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            image: DecorationImage(
                                image: new AssetImage("images/background.png"),
                                fit: BoxFit.cover
                            )
                        ),

                        child: Container(
                         // margin: EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Container(
                                    margin: EdgeInsets.only(top: 0, bottom: 0),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: new BorderRadius.only(topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0),),
                                        image: DecorationImage(image: new AssetImage("images/Competition_img.png"), fit: BoxFit.cover)),
                                    child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          user_image(),
                                          Image.asset(
                                            'images/trophy_img.png',
                                            width: 90,
                                            height: 80,
                                            fit: BoxFit.fill,
                                          ),
                                          winner_user_image(),
                                        ])),

                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: CircularPercentIndicator(
                                    radius: 100.0,
                                    lineWidth: 25.0,
                                    percent: 1,
                                    center: const Text("100%",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Montserrat",
                                            color: Colors.black)),
                                    backgroundColor: Color(0x4B053909),
                                    progressColor: Color(0xff249316),
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
                                        EdgeInsets.only(bottom: 8, top: 8),
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
                                                      child: const Icon(
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
                                    "Congratulations you have won the competition!",
                                      textAlign: TextAlign.center,
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
                                          decoration: BoxDecoration(
                                            color: Color(0xff29392a),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1 // red as border color
                                            ),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(left: 20, right: 0),
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              left: 40,
                                              right: 40,
                                              bottom: 10),
                                          height: 40,
                                          child: Text(
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

  showContent() {
    return SafeArea(
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 50),
            child:
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
          ),
          Expanded(
              child: new SingleChildScrollView(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(30.0),
                            topRight: const Radius.circular(30.0),
                          ),
                          image: DecorationImage(
                              image: new AssetImage("images/background.png"),
                              fit: BoxFit.cover)
                      ),
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 5, right: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(20.0),
                                        topRight: const Radius.circular(20.0),
                                      ),
                                      image: DecorationImage(
                                          image: new AssetImage(
                                              "images/Competition_img.png"),
                                          fit: BoxFit.fill)),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        user_image(),
                                        Image.asset(
                                          'images/trophy_img.png',
                                          width: 90,
                                          height: 80,
                                          fit: BoxFit.fill,
                                        ),
                                        winner_user_image(),
                                      ])),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 20, bottom: 20, left: 10, right: 10),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                    top: 5, left: 5, right: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: new CircularPercentIndicator(
                                  radius: 100.0,
                                  lineWidth: 25.0,
                                  percent: 0.6,
                                  center: new Text("60%",
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Montserrat",
                                          color: Colors.black)),
                                  backgroundColor: Color(0x4B053909),
                                  progressColor: Color(0xff29392a),
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Text("Correct Answer 100%",
                                          style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              color: Colors.black)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: 8,
                                          top: 8,
                                          left: 10,
                                          right: 10),
                                      child: Text("Wrong Answer 0%",
                                          style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              color: Colors.black)),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Text("Missed Questions 0%",
                                          style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              color: Colors.black)),
                                    )
                                  ]),
                              SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 40),
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
                                            decoration: BoxDecoration(
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 20,
                                                            top: 20),
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            width: 1.0,
                                                            color: Color(
                                                                0x735CC15C)),
                                                      ),
                                                    ),
                                                    child: Text(country,
                                                        style: const TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Montserrat",
                                                            color:
                                                                Colors.black)),
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
                                    top: 30, left: 10, right: 10, bottom: 40),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff063464),
                                          border: Border.all(
                                              color: Color(0xff063464),
                                              width: 1 // red as border color
                                              ),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        alignment: Alignment.center,
                                        margin:
                                            EdgeInsets.only(left: 20, right: 0),
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 40,
                                            right: 40,
                                            bottom: 10),
                                        height: 40,
                                        child: Text(
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
                      ))))
        ],
      )),
    );
  }
}
