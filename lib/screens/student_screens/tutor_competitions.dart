import 'package:abacus_app/screens/student_screens/competition_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Competitions extends StatefulWidget {
  static const String routeName = '/Competitions';

  @override
  State<StatefulWidget> createState() => _Competitions();
}

class _Competitions extends State<Competitions> {
  List<String> levelList = [
    "Level 1",
    "Level 2",
    "Level 3",
    "Level 4",
    "Level 5",
    "Level 6",
    "Level 7",
    "Level 8",
    "Level 9",
    "Level 10",
    "Level 11",
    "Level 12"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark
        //color set to transperent or set your own color
        ));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
        //color set to transperent or set your own color
        ));
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light),
          title: const Text("Competition"),
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
              ),
            ),
          ),
          titleTextStyle: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: "Montserrat"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: buildBody());
  }

  Widget buildBody() {
    return SizedBox(
      //height: 800,
      width: double.infinity,
      child: Container(
          margin: EdgeInsets.all(0),
          child: Stack(children: [
            Image(
                image: new AssetImage("images/home_bg.png"), fit: BoxFit.fill),
            levelListFun(),
            showContent(),
          ])),
    );
  }

  levelListFun() {
    return SafeArea(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 0, right: 10, bottom: 20),
          child: Row(
            children: levelList.map((level) {
              return Container(
                  alignment: Alignment.center,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              bottom: 10, top: 10, left: 20, right: 20),
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0x735CC15C),
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: Text(level,
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Montserrat",
                                  color: Colors.white)),
                        ),
                      ]));
            }).toList(),
          )),
    ));
  }

  showContent() {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.only(top: 60),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                        child: Container(
                            margin: EdgeInsets.only(
                                top: 40.0, left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image:
                                        new AssetImage("images/bg_orange.png"),
                                    fit: BoxFit.cover)),
                            child: data()),
                        onTap: () =>
                            /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameLevel(),
                          ),
                        )*/
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompetitioonResult(),
                              ),
                            ));
                  },
                ),
              )
            ],
          )),
    );
  }

  right_image() {
    return SafeArea(
        child: Stack(
      children: [
        Container(
          child: new Image(
            image: new AssetImage("images/game_image.png"),
            height: 120,
          ),
        ),
      ],
    ));
  }

  data() {
    return Row(children: [
      Expanded(
        flex: 7,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Addition and Subtraction",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Montserrat",
                  color: Colors.white,
                ),
              ),
              Text(
                "Pattern: 1 & 2 & 3 & 4 Digit 10 Question \nTotal : 10 Marks \nTime : 10 Minutes",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
      Expanded(
          flex: 3,
          child: Container(
            // padding: EdgeInsets.only(right: 10),
            child: new Image(
              image: new AssetImage("images/game_image.png"),
              height: 140,
            ),
          ))
    ]);
  }
}
