import 'dart:async';
import 'package:abacus_app/screens/marge_screens/landing_screen.dart';
import 'package:abacus_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/screen.dart';
import '../student_screens/studentHome.dart';
import '../tutor_screens/TutorHomeScreen.dart';

class Splash extends StatefulWidget {

  const Splash({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Timer(const Duration(seconds: 4), () => checkLoginStatus());

  }

  checkLoginStatus() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentIDValue = prefs.getString(ApiConstants.studentID).toString();
    String tutorIDValue = prefs.getString(ApiConstants.tutorID).toString();
    String loginTypeValue = prefs.getString(ApiConstants.loginType).toString();

    if(loginTypeValue.isNotEmpty){

      if(loginTypeValue == "0" && studentIDValue.isNotEmpty){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const StudentHome()), (Route<dynamic> route) => false);
      }else if(loginTypeValue == "1" && tutorIDValue.isNotEmpty){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const TutorHome()), (Route<dynamic> route) => false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Landing()), (Route<dynamic> route) => false);
      }

    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Landing()), (Route<dynamic> route) => false);
    }


  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(

        padding: EdgeInsets.only(top: 105,left: SizeConfig.blockSizeHorizontal*5,right: SizeConfig.blockSizeHorizontal*5),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bg_splash.png"),
                fit: BoxFit.fill)
        ),
        child: Column(
          children: [
            const Text(
              "App is allowing users to learn & Grow their Brains",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 22.0,
                          color: Color(0xFF003974),
                          fontFamily: "Calistoga",
                          fontWeight: FontWeight.w400,
                        ),

            ),
            logo()
          ],
        ));

  }

  logo() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: const Image(
        image: AssetImage('images/logo.png'),
        height: 140,
      ),

    );
  }

}