import 'package:abacus_app/screens/student_screens/studenLoginScreen.dart';
import 'package:flutter/material.dart';
import '../../utils/screen.dart';
import '../../utils/utils.dart';
import '../franchise_screens/FranchiseHomeScreen.dart';
import '../tutor_screens/tutor_login_screen.dart';

class Landing extends StatefulWidget {
  static const String routeName = '/LandingScreen';

  @override
  State<StatefulWidget> createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Container(
        height: SizeConfig.blockSizeVertical * 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.png"), fit: BoxFit.fill),
        ),
        child: Stack(
          children: [

            Container(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /*    App Logo Function   */
                  logo(),

                  /*    Student, Tutor    */
                  Row(children: [

                    buttonFun("Student","0"),
                    buttonFun("Tutor","1"),

                  ],),

                  /*    Franchise, Coordinator    */
                  Row(children: [

                    buttonFun("Franchise","2"),
                    buttonFun("Coordinator","3"),

                  ],),

                ],
              ),
            ),

            /*   Skip Login Function   */
            // skipLogin(),
          ],
        ),
      ),
    );
  }

  /*    Logo Function    */
  logo() {
    return Container(
      margin: const EdgeInsets.only(top: 0, bottom: 40),
      child: const Image(
        image: AssetImage('images/logo.png'),
        height: 150,
      ),
    );
  }

  /*    Button Function    */
  buttonFun(String name, String loginType) {

    return Expanded(
        flex: 5,
        child : Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3, left: 10, right: 10),
          height: 50.0,
          child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                //  32  backgroundColor: const Color(0xFF063464),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: const BorderSide(color: Color(0xFF063464))),
                  elevation: 6.0
              ),
              onPressed: () {

                if(loginType == "2"){

                  Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => MyApp()),
                    MaterialPageRoute(builder: (context) => FranchiseHomeScreen()),
                  );

                }
                else if(loginType == "3"){

                }
                else if(loginType == "1"){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TutorLoginScreen(loginType: loginType, loginTypeName: name)),
                  );
                }
                else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginStudent(loginType: loginType, loginTypeName: name)),
                  );
                }

              },
              child: Text(
                name,
                style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              )),

      )
    );

  }

  /*    Skip Login Function    */
  skipLogin(){

    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("You want to explore the app?",
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 18.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            GestureDetector(
                onTap: () {
                  launchScreen(context, TutorLoginScreen.routeName);
                },
              child: const Text("Skip Login",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20.0,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF063464))),
            )

          ])
    );

  }


}
