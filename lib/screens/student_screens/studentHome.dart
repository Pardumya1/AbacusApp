import 'package:abacus_app/screens/student_screens/StudentAttendanceScreen.dart';
import 'package:abacus_app/screens/student_screens/studentOnlineClasses.dart';
import 'package:abacus_app/screens/student_screens/selected_level.dart';
import 'package:abacus_app/screens/student_screens/student_subscribed_classes.dart';
import 'package:abacus_app/screens/student_screens/student_test_screen%20.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../marge_screens/about_us.dart';
import 'package:abacus_app/screens/student_screens/MyLevel.dart';
import 'package:abacus_app/screens/student_screens/studentProfile.dart';
import 'package:abacus_app/screens/student_screens/today_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../marge_screens/contact_us_screen.dart';
import '../marge_screens/landing_screen.dart';
import '../marge_screens/play_game.dart';
import '../../utils/constants.dart';
import '../../utils/screen.dart';
import '../../utils/utils.dart';
import '../marge_screens/websiteScreen.dart';
import 'StudentCompensationClassScreen.dart';

class StudentHome extends StatefulWidget {
  static const String routeName = '/StudentHome';

  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StudentHome();
}

class _StudentHome extends State<StudentHome> with WidgetsBindingObserver {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String studentLoginType = "";

  /*   Demo Data   */
  final backgroundList = [
    'images/bg_orange.png',
    'images/bg_orange.png',
    'images/bg_orange.png',
    'images/bg_orange.png'
  ];
  final titleList = [
    'Subscribed Courses Section',
    'Test Section',
    'Go to Today scheduled Sessions',
    'Apply For Compensation Classes'
  ];
  final imageList = [
    'images/home1.png',
    'images/image9.png',
    'images/image10.png',
    'images/compensation_image.png'
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    getStringValuesSF();

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
      // user returned to our app
    }
    else if (state == AppLifecycleState.inactive) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark));
      // app is inactive
    }
    else if (state == AppLifecycleState.paused) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark));
      // user is about quit our app temporally
    }

  }

  Widget createDrawerBodyItem({IconData? icon, String? text, String? onTap}) {
    return InkWell(
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              Icon(icon),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  text!,
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: "Montserrat",
                      color: Colors.black),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
          setState(() {
            launchScreen(context, onTap!);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            drawer: Drawer(
              child: getStudentDrawer(),
            ),
            body: buildBody()));
  }


  Widget buildBody() {
    return SizedBox(
      width: double.infinity,
      child: Container(
          margin: const EdgeInsets.all(0),
          child: Stack(children: [
            const Image(
                image: AssetImage("images/background.png"), fit: BoxFit.fill),
            showContent(),
          ])),
    );
  }

  /*      ShowContent Function     */
  showContent() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [

                IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(
                        'images/menu_icon.png',
                        width: 25,
                        height: 18,
                        color: const Color(0xFF003974),
                        fit: BoxFit.fill,
                      ),
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    }),
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: const EdgeInsets.only(right: 10, top: 10),
                      child: Image.asset(
                        "images/logo.png",
                        width: 30,
                        height: 30,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentProfile(studentLoginType : studentLoginType),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, top: 10),
                    child: Image.asset(
                      "images/profile_icon.png",
                      width: 30,
                      height: 30,
                    ),
                  ),
                )

              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, position) {
                return GestureDetector(
                    onTap: () =>

                    (() {
                      if(position == 0){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubscribedClasses(),
                          ),
                        );
                      }
                      else if(position == 1){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentTestScreen(),
                          ),
                        );
                      }
                      else if(position == 2){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TodaySession(),
                          ),
                        );
                      }
                      else if(position == 3){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentCompensationClassScreen(),
                          ),
                        );
                      }
                    }()),

                    child: Container(
                        margin: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              child: Stack(
                                children: [
                                  Container(
                                    //height: 220,
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        top: 20.0,
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 20.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                backgroundList[position]
                                                    .toString()),
                                            fit: BoxFit.cover)),

                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 5,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        titleList[position],
                                                        style: const TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Montserrat",
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 10),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                          color: const Color(
                                                              0xFF2F3331),
                                                        ),
                                                        child: const Text(
                                                          "Learn more",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Montserrat",
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 5,
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 0),
                                                    child: Image(
                                                      image: AssetImage(
                                                          imageList[position]),
                                                      height: 160,
                                                    )))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )));
              },
            ),
          )
        ],
      ),
    );
  }


  /*   Student Section Start   */
  getStudentDrawer() {
    return SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("images/stud_bg_navdrawer.png"),
                  fit: BoxFit.cover,
                )),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15),
                      //apply padding to all four sides
                      child: Image(
                          image: AssetImage("images/logo_white.png"),
                          width: 90,
                          height: 90),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      //apply padding to all four sides
                      child: Text("IDEA PLAY ABACUS\nINDIA PVT. LTD.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: SizeConfig.blockSizeVertical * 1.4,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              )),
          Expanded(
              child: SingleChildScrollView(
                child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    /*     Home     */
                    InkWell(
                      onTap: () {
                        drawerFunction(1);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/menu_home.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF0C4A89),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: const Text("Home",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Color(0xFF0C4A89)))),
                          ],
                        ),
                      ),
                    ),

                    /*      Classes     */
                    InkWell(
                      onTap: () {
                        drawerFunction(2);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/menu_classes.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("Online Classes",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),

                          ],
                        ),
                      ),
                    ),

                    /*      Competition     */
                    InkWell(
                      onTap: () {
                        drawerFunction(3);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/menu_comp.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("Competition",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),

                    /*      Virtual Abacus     */
                    InkWell(
                      onTap: () {
                        drawerFunction(4);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/menu_abacus.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("Virtual Abacus",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),

                    /*      Play Games    */
                    InkWell(
                      onTap: () {
                        drawerFunction(5);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/menu_game.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("Play Games",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),

                    /*      My Level     */
                    InkWell(
                      onTap: () {
                        drawerFunction(6);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/level_icon.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("My Level",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),

                    /*      Attendance     */
                    InkWell(
                      onTap: () {
                        drawerFunction(13);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/attendance_icon.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("My Attendance",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),

                    /*      Blogs     */
                    InkWell(
                      onTap: () {
                        drawerFunction(7);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/blog_icon.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("Blogs",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),

                    /*      Visit Website     */
                    InkWell(
                      onTap: () {
                        drawerFunction(8);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/menu_visit.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("Visit Website",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),

                    /*      About Abacus     */
                    InkWell(
                      onTap: () {
                        drawerFunction(9);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/menu_about.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("About Abacus",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),

                    /*      My Account     */
                    InkWell(
                      onTap: () {
                        drawerFunction(10);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/menu_account.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("My Account",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),

                    /*      Contact Us    */
                    InkWell(
                      onTap: () {
                        drawerFunction(11);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/menu_contact.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("Contact Us",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    ),

                    /*     Logout      */
                    InkWell(
                      onTap: () {
                        drawerFunction(12);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                'images/menu_logout.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                                color: const Color(0xFF746C6C),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 15),
                                child: const Text("Logout",
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
            ),
          )),
        ],
      ),
    ));
  }

  void drawerFunction(var nextScreen) {
    Navigator.pop(context);
    switch (nextScreen) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentHome(),
          ),
        );
        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => studentOnlineClass(),
          ),
        );
        break;

      case 3:
        Fluttertoast.showToast(
          msg: "Competition link will be provided at the time of exam",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        break;

      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Game(),
          ),
        );
        break;

      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SelectedLevel(levelStatus: "0", levelId: "1", name: "PLay Games"),
          ),
        );
        break;

      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LevelScreen(),
          ),
        );
        break;

      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WebsiteScreen(link : "https://www.playabacusindia.com/blog/"),
          ),
        );
        break;

      case 8:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WebsiteScreen(link : "https://www.playabacusindia.com/"),
          ),
        );
        break;

      case 9:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutUs(),
          ),
        );
        break;

      case 10:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentProfile(studentLoginType : studentLoginType),
          ),
        );
        break;

      case 11:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactUsScreen(),
          ),
        );
        break;

      case 12:
        removeValues();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Landing()),
            (Route<dynamic> route) => false);
        break;

      case 13:
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StudentAttendanceScreen()));
        break;
    }
  }

/*   Student Section End   */


/*      shared_preferences         */
  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginTypeValue = prefs.getString(ApiConstants.loginType).toString();

    if(loginTypeValue == "1"){
      prefs.remove(ApiConstants.studentCode);
      prefs.remove(ApiConstants.studentRollNo);
      prefs.remove(ApiConstants.studentAge);
      prefs.remove(ApiConstants.studentDOJ);
      prefs.remove(ApiConstants.studentDOC);
      prefs.remove(ApiConstants.studentScheme);
      prefs.remove(ApiConstants.studentTerm);
      prefs.remove(ApiConstants.studentSchool);
    }
    prefs.remove(ApiConstants.studentName);
    prefs.remove(ApiConstants.studentEmail);
    prefs.remove(ApiConstants.studentStandard);
    prefs.remove(ApiConstants.studentGender);
    prefs.remove(ApiConstants.studentDOB);
    prefs.remove(ApiConstants.studentAddress);
    prefs.remove(ApiConstants.studentMode);
    prefs.remove(ApiConstants.studentPhoneNumber);
    prefs.remove(ApiConstants.studentDeviceToken);
    prefs.remove(ApiConstants.studentDeviceType);
    prefs.remove(ApiConstants.studentID);
    prefs.remove(ApiConstants.loginType);
    prefs.remove(ApiConstants.accessTokenSP);
    prefs.remove(ApiConstants.studentLoginType);

  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentLoginType = prefs.getString(ApiConstants.studentLoginType).toString();
  }



}




