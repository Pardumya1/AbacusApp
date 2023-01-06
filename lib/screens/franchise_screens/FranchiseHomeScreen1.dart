import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../marge_screens/landing_screen.dart';
import '../tutor_screens/TutorProfileScreen.dart';
import 'FranchiseApplyScreen.dart';
import 'FranchiseCentreScreen.dart';

class FranchiseHomeScreen extends StatefulWidget {

  static const String routeName = '/FranchiseHomeScreen';
  const FranchiseHomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FranchiseHomeScreen();

}

class _FranchiseHomeScreen extends State<FranchiseHomeScreen> with WidgetsBindingObserver {

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
    }
    else if (state == AppLifecycleState.paused) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark));
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
              MaterialPageRoute(builder: (context) => const FranchiseApplyScreen()),
            );
          },
          label: const Text('Apply for a new centre'),
          icon: const Icon(Icons.thumb_up),
          backgroundColor: Colors.pink,
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
          child: Stack(children: [
            const Image(
                image: AssetImage("images/background.png"), fit: BoxFit.fill),
            showContent(),
          ])),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Landing()),
                    );
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
                      _launchURLApp();
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


          /*       Heading      */
          Container(
            margin: const EdgeInsets.only(top: 20, left: 15),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Centre List",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: Color(0xFF003974)),
            ),
          ),

          /*     GridView List View      */
          Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: choices.length,
                itemBuilder: (context, index) => ItemTile(index, choices),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 4.5)),
            ),
          ))

        ],
      ),
    );
  }
}


/*    Visit Website     */
// launchUrlBrowser() async {
//
//   const url = 'https://www.playabacusindia.com/';
//   if (await launch(url)) {
//     await canLaunch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
//
//   // var url = Uri.parse("https://www.geeksforgeeks.org/");
//   // if (await canLaunchUrl(url)) {
//   //   await launchUrl(url);
//   // } else {
//   //   throw 'Could not launch $url';
//   // }
//
// }

_launchURLApp() async {
  var url = Uri.parse("https://www.playabacusindia.com/");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FranchiseCentreScreen(),
            ),
          );
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

          child: Row(
            children: [

              Container(
                padding: const EdgeInsets.only(left: 10, right: 30),
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
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                            color: Colors.black),
                      ),
                    )

                  ],
                ),
              ),

              Expanded(
                flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Text(
                          "Location",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                              color: Colors.black),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Text(
                          "#2A, I FLOOR, DR RADHAKRISHNAN SALAI, 3RD STREET, MYLAPORE, CHENNAI – 600 004, TAMILNADU.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              color: Colors.black),
                        ),
                      ),

                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Column(
                            children: [

                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  "Teacher Count",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Colors.black),
                                ),
                              ),

                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  "11",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Colors.black),
                                ),
                              ),

                            ],
                          ),

                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [

                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const Text(
                                    "Student Count",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Montserrat",
                                        color: Colors.black),
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const Text(
                                    "1021",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Montserrat",
                                        color: Colors.black),
                                  ),
                                ),

                              ],
                            ),
                          )

                        ],
                      ),

                    ],
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

  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),
  const Choice(title: 'Centre Name', image: "images/institution_icon.png"),

];
