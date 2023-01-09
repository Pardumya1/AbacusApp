import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import 'assessment_paper_screen .dart';
import 'model/levelListModel.dart';

class LevelScreen extends StatefulWidget {
  static const String routeName = '/LevelScreen';

  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LevelScreen();

}

class _LevelScreen extends State<LevelScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  List<levelListModel> levelList = [];

  @override
  void dispose() {

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark
        )
    );

    super.dispose();
  }

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
            title: const Text("My Level"),
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

            titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: "Montserrat"),
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
              const Image(
                  image: AssetImage("images/home_bg.png"),
                  fit: BoxFit.fill),

              showContent()

            ]
        )
    );
  }

  /*   show Content  */
  showContent() {
    return SafeArea(
        child: FutureBuilder(
        future: getDataFunction(),
            builder: (context, snapshot){

          if(snapshot.connectionState == ConnectionState.done) {
            return Container(
                margin: const EdgeInsets.only(top:20),
                padding: const EdgeInsets.only(top:10,bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,//Radius.circular(20)
                    ),
                    image: const DecorationImage(
                        image: AssetImage("images/background.png"),
                        fit: BoxFit.cover
                    )
                ),

                child: GridView.builder(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 6/2
                    ),
                    itemCount: levelList.length,
                    itemBuilder: (BuildContext ctx, index) {

                      var backgroundColor = 0;
                      var textColor = 0;
                      var untickLevel = 0;

                      if(levelList[index].levelStatus == "1"){
                        backgroundColor = 0xfff0f3ff;
                        textColor = 0xff006e3c;
                        untickLevel = 0xFFD2D0D0;
                      }else if(levelList[index].levelStatus == "2"){
                        textColor = 0xfff0f3ff;
                        backgroundColor = 0xffeca214;
                        untickLevel = 0xfff0f3ff;
                      }else{
                        backgroundColor = 0xff006e3c;
                        textColor = 0xfff0f3ff;
                        untickLevel = 0xfff0f3ff;
                      }

                      return GestureDetector(
                        onTap: () {

                          if(levelList[index].levelStatus == "2"){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const AssessmentPaperScreen()));
                          }

                        },
                        child: Container(

                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Color(backgroundColor),
                                border: Border.all(color: Color(untickLevel), // Set border color
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(5)
                            ),

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:[
                                  Image.asset(
                                    'images/untick_level.png',
                                    width: 24,
                                    height: 24,
                                    color: Color(untickLevel),
                                    fit: BoxFit.fill,
                                  ),

                                  const SizedBox(width: 10),

                                  Flexible(child: Text(
                                      levelList[index].LevelName,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Montserrat",
                                          color: Color(textColor)
                                      )
                                  ))

                                ]
                            )

                        ),
                      );
                    }
                )

            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }

        })
    );
  }


  /*   get Level Details APIs     */
  Future<void> getDataFunction() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try{
      final response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.studentLevelListEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
          body: {
            'student_id' : prefs.getString(ApiConstants.studentID),
            'student_type' : prefs.getString(ApiConstants.studentLoginType),
            'level_code' : prefs.getString(ApiConstants.studentTerm),
          }
      );

      Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == "true") {

        var levelListArray = data['data'] as List;
        levelList.clear();


        /*   levelList   */
        for (var i = 0; i < levelListArray.length; i++) {
          var levelDataObj = levelListArray[i];

          levelList.add(levelListModel(levelDataObj["id"].toString(), levelDataObj["LevelGUID"].toString(),
              levelDataObj["LevelCode"].toString(), levelDataObj["LevelName"].toString(),  levelDataObj["StreamName"].toString(),
              levelDataObj["SortOrder"].toString(),levelDataObj["levelStatus"].toString() ));

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

