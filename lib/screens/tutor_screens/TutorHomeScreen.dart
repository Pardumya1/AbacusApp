
import 'package:abacus_app/screens/tutor_screens/TutorLeaveScreen.dart';
import 'package:abacus_app/screens/tutor_screens/tutor_assign_courses.dart';
import 'package:abacus_app/screens/tutor_screens/tutor_test_screen%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../marge_screens/contact_us_screen.dart';
import '../marge_screens/landing_screen.dart';
import '../marge_screens/play_game.dart';
import '../marge_screens/websiteScreen.dart';
import 'TutorMoreScreen.dart';
import 'TutorProfileScreen.dart';
import 'TutorScheduledScreen.dart';
import 'TutorTodaySessionScreen.dart';

class TutorHome extends StatefulWidget {

  static const String routeName = '/TutorHome';
  const TutorHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TutorHome();
}

class _TutorHome extends State<TutorHome> with WidgetsBindingObserver {

  var loginUser = 0;
  late String data, val;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final loader = GlobalKey<ScaffoldState>();


  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TutorLeave()),
          );
        },
        label: const Text('Leave Apply'),
        icon: Image.asset(
          "images/leave_icon.png",
          height: 20,
          width: 20,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepOrange,
        hoverColor: Colors.transparent,
      ),
    );
  }

  Widget buildBody() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Container(
          margin: const EdgeInsets.all(0),
          child: showContent(),),
    );
  }

  showContent() {
    return SafeArea(
      child: Column(
        children: <Widget>[

          /*     Toolbar View      */
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
                    Container(
                        margin: const EdgeInsets.only(bottom: 5, left: 5),
                        child: const Text(
                          "Dashboard",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: Colors.black),
                        )),
                  ],
                ),

                GestureDetector(
                  onTap: () {
                    removeValues();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Landing()),
                            (Route<dynamic> route) => false);
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
                            "Logout",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                                color: Colors.black),
                          )),

                    ]),)
              ],
            ),
          ),


          /*     Top Options View     */
          Container(
            margin: const EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () => (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TutorProfile()),
                      );
                    }()),

                    child:Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFB06FE3), Color(0xFFE0A1DA)]),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        border: Border.all(
                          color: const Color(0x1A000000),
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      margin:
                          const EdgeInsets.only(top: 15, bottom: 5, right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [

                          Text(
                            "View Profile",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat",
                                color: Color(0xFF003974)),
                          ),

                          Image(
                            image: AssetImage("images/forward_icon.png"),
                            height: 20,
                            width: 20,
                          ),

                      ],)),)
                ),

                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () => (() {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WebsiteScreen(link : "https://www.playabacusindia.com/"),
                        ),
                      );

                      // _launchURLApp();
                    }()),

                    child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFF8F97), Color(0xFFF8B487)]),
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          border: Border.all(
                            color: const Color(0x1A000000),
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        margin:
                        const EdgeInsets.only(top: 15, bottom: 5, left: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [

                            Text(
                              "Visit Website",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                  color: Color(0xFF003974)),
                            ),

                            Image(
                              image: AssetImage("images/forward_icon.png"),
                              height: 20,
                              width: 20,
                            ),

                          ],)),),
                ),
              ],
            ),
          ),


          /*     GridView List View      */
          Expanded(
              child : Container(
                margin: const EdgeInsets.only(bottom: 80),
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: choices.length,
                  itemBuilder: (context, index) => ItemTile(index, choices),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.8)),
                ),
              )
          )
        ],
      ),
    );
  }

  /*      shared_preferences         */
  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(ApiConstants.tutorID);
    prefs.remove(ApiConstants.tutorName);
    prefs.remove(ApiConstants.tutorEmail);
    prefs.remove(ApiConstants.tutorPhoneNumber);
    prefs.remove(ApiConstants.tutorAddress);
    prefs.remove(ApiConstants.tutorDeviceToken);
    prefs.remove(ApiConstants.tutorDeviceType);
    prefs.remove(ApiConstants.tutorTutorImage);
    prefs.remove(ApiConstants.tutorFranchiseeName);
    prefs.remove(ApiConstants.loginType);
    prefs.remove(ApiConstants.accessTokenSP);

  }

}


/*   Home Item List Function   */
class ItemTile extends StatelessWidget {
  final int itemNo;
  final List<Choice> choices;

  const ItemTile(
    this.itemNo,
    this.choices,
  );

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () =>(() {

          if(itemNo == 4){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TutorTestScreen(),
              ),
            );
          }
          else if(itemNo == 3){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TutorScheduledClass(),
              ),
            );
          }
          else if(itemNo == 2){

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TutorTodaySessionScreen(),
              ),
            );

          }
          else if(itemNo == 1){
            Fluttertoast.showToast(
              msg: "Competition link will be provided at the time of exam",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );

          }
          else if(itemNo == 0){

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TutorAssignCourses(),
              ),
            );

          }
          else if(itemNo == 6){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Game(),
              ),
            );
          }
          else if(itemNo == 8){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactUsScreen(),
              ),
            );
          }
          else{
            null;
          }

        }()),
        child: Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFCFCFCF),
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 4.0,
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image(
                image: AssetImage(choices[itemNo].image),
                height: 80,
                width: 80,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  choices[itemNo].title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      color: Colors.black),
                ),
              )

            ],
          )

        )
    );

  }
}

/*   Item Data     */
class Choice {

  const Choice({required this.title, required this.image});

  final String title;
  final String image;

}

List<Choice> choices = <Choice>[

  const Choice(title: 'Assigned Courses', image: "images/assign_img.png"),
  const Choice(title: 'Competition', image: "images/competitive_icon.png"),
  const Choice(title: 'Today\'s Session', image: "images/session_icon.png"),
  const Choice(title: 'Scheduled Classes', image: "images/schedule_icon.png"),

  const Choice(title: 'Test', image: "images/test_image.png"),
  const Choice(title: 'Attendance', image: "images/calendar_icon.png"),
  const Choice(title: 'Virtual Abacus', image: "images/virtual_icon.png"),
  const Choice(title: 'Compensation Classes', image: "images/compensation_classes_icon.png"),
  const Choice(title: 'Contact Us', image: "images/contact_icon.png"),

];
