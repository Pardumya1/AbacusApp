import 'dart:convert';

import 'package:abacus_app/screens/student_screens/play_screen.dart';
import 'package:abacus_app/screens/student_screens/quiz/screens/quizz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import 'model/playGamesModel.dart';


class PlayGamesList extends StatefulWidget {

  static const String routeName = '/PlayGamesList';
  const PlayGamesList({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _PlayGamesList();
}

class _PlayGamesList extends State<PlayGamesList> with WidgetsBindingObserver {


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<playGamesModel> gamesList = [];
  List<String> questionsList = [];

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
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark
          ),
          title: const Text("Games List"),
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
              ),
            ),
          ),
          titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Color(0xFF47473F), fontFamily: "Montserrat"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
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

            showContent(),

          ])),
    );
  }

  showContent() {
    return SafeArea(
        child: FutureBuilder(
          future: getDataFunction(),
            builder: (context, snapshot){

              if(snapshot.connectionState == ConnectionState.done){
                return gamesList.isNotEmpty ? Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 20),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: gamesList.length,
                    itemBuilder: (context, index) => ItemTile(index, gamesList),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 0,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 8)),
                  ),
                ) : const Center(child: Text("No Data Found!"));
              }
              else{
                return const Center(child: CircularProgressIndicator());
              }

          })
    );
  }

  /*    Get Function Api       */
  Future<void> getDataFunction() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();


    try{
      final response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.playGamesEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
          body: {
            'level' : "EL-05",
          }
      );

      Map<String, dynamic> data = json.decode(response.body);
      debugPrint("Data : $data");

      if (data['status'] == "true") {

        var employee_list = data['data'] as List;
        gamesList.clear();

        /*   standard_data   */
        for (var i = 0; i < employee_list.length; i++) {
          var employeeDataObj = employee_list[i];
          gamesList.add(playGamesModel(employeeDataObj["TestDuration"].toString(), employeeDataObj["id"].toString(), employeeDataObj["TestName"].toString(),
              employeeDataObj["Level"].toString(), employeeDataObj["Image"].toString(), employeeDataObj["Status"].toString(),
              employeeDataObj["Time"].toString(), employeeDataObj["questions"]));
        }

      }
      else {
        Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }

    }catch(e){
      print("Error : $e");

    }
  }

}


/*   Home Item List Function   */
class ItemTile extends StatelessWidget {
  final int itemNo;
  final List<playGamesModel> gamesList;

  const ItemTile(
      this.itemNo,
      this.gamesList,
  );

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () =>(() {

          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => QuizzScreen(name : gamesList[itemNo].TestName, id : gamesList[itemNo].id),
              builder: (context) => PlayScreen(testDuration: gamesList[itemNo].testDuration, gameId: gamesList[itemNo].id,levelId: gamesList[itemNo].Level, name : gamesList[itemNo].TestName,  questionsList : gamesList[itemNo].questionList, levelStatus: 's',)
            ),
          );

        }()),
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Container(
                    margin: const EdgeInsets.only(left: 0),
                    child: Text(
                      gamesList[itemNo].TestName,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat",
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 0, top: 5),
                    child: Text(
                      gamesList[itemNo].Level,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat",
                          color: Colors.black),
                    ),
                  ),

                ],
              ),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(left: 0, bottom: 5),
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Container(

                  ),
                ),
                ),

                // Text(
                //   gamesList[itemNo].Status,
                //   textAlign: TextAlign.center,
                //   style: const TextStyle(
                //       fontSize: 15,
                //       fontWeight: FontWeight.w600,
                //       fontFamily: "Montserrat",
                //       color: Colors.black),
                // ),

              ],
            )

            ],
          )

        )
    );

  }


}
