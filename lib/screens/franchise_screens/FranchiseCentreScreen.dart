import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FranchiseCentreScreen extends StatefulWidget {
  static const String routeName = '/TutorMoreScreen';

  const FranchiseCentreScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FranchiseCentreScreen();

}

class _FranchiseCentreScreen extends State<FranchiseCentreScreen> with WidgetsBindingObserver {

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
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark
          ),
          title: const Text("Centre Name"),
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
                color: Colors.black,
                // fit: BoxFit.fill,
              ),
            ),

          ),
          titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: "Montserrat"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: buildBody());
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

          /*     GridView List View      */
          Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 40),
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
                        (MediaQuery.of(context).size.height / 2.5)),
            ),
          ))
        ],
      ),
    );
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

  const Choice(title: 'Teachers List', image: "images/student_icon.png"),
  const Choice(title: 'Students List', image: "images/teacher_icon.png"),


];
