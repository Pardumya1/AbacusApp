

import 'dart:convert';

import 'package:abacus_app/screens/student_screens/quiz/screens/quizz_screen.dart';
import 'package:abacus_app/screens/student_screens/wigets/test_cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import 'model/testResultModel.dart';
import 'model/upcomingTestModel.dart';


class StudentTestScreen extends StatefulWidget {

  static const String routeName = '/StudentTestScreen';
  const StudentTestScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StudentTestScreen();

}

class _StudentTestScreen extends State<StudentTestScreen> {

  List<upcomingTestModel> upComingList = [];
  List<testResultModel> testResultsList = [];

  @override
  void initState() {
    super.initState();
  }

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

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light
        )
    );

    return Stack(
      children: <Widget>[

        Image.asset(
          "images/home_bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),

        MaterialApp(
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.light
                ),
                title: const Text('Test'),
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

                bottom: const TabBar(
                  tabs: [
                    Tab(text: "Upcoming Test"),
                    Tab(text: "Test Results"),
                  ],
                ),

              ),
              body: buildBody(),
            ),
          ),
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

  showContent() {
    return SafeArea(
      child: FutureBuilder(
          future: getDataFunction(),
          builder: (context, snapshot){

            if(snapshot.connectionState == ConnectionState.done) {
              return Container(

                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F0F0),
                  border: Border.all(
                    color: Color(0xBBFAFAFA),
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),

                ),
                child: TabBarView(
                  children: [
                    upComingList.isNotEmpty ? listViewUpcomingSection() : const Center(child: Text("No Data Found!")),
                    listViewResultsSection(),
                  ],
                ),
              );
            }else{
              return const Center(child: CircularProgressIndicator());
            }

          })

    );

  }

  listViewUpcomingSection(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: upComingList.length,
        itemBuilder: (context, index) {
          final post = upComingList[index];
          return TestCellWidget(
              title: post.TestName,
              image: post.Image,
              level: post.Level,
              date: post.StartDate,
              startTime: post.Start_Time,
              type: "0",
              onClick: () {

                if(upComingList[index].testStatus == '0'){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuizzScreen(name : upComingList[index].TestName, id : upComingList[index].id, questionList : upComingList[index].questionList,
                      level: upComingList[index].Level),
                    ),
                  );
                }else{
                  Fluttertoast.showToast(
                    msg: "This test has already been submitted by you.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );
                }


              });
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }

  listViewResultsSection(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: testResultsList.length,
        itemBuilder: (context, index) {
          final post = testResultsList[index];
          return TestCellWidget(
              title: post.Test_Name,
              image: post.TotalQuestion,
              level: post.Level,
              date: post.resultStatus,
              startTime: post.StudentMarks,
              type: "1",
              onClick: () {

                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => QuizzScreen(name : "TestName", id : "id"),
                //   ),
                // );

              });
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }


  /*    Get Function Api       */
  Future<void> getDataFunction() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      final response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.testStudentEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
          body: {
            'student_id' : prefs.getString(ApiConstants.studentID),
            'student_type' : prefs.getString(ApiConstants.studentLoginType),
            'level' : "RL-03",
          }
      );

      Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == "true") {

        var testList = data['upComingData'] as List;
        var resultList = data['testResultData'] as List;
        upComingList.clear();
        testResultsList.clear();


        /*   upComingList   */
        for (var i = 0; i < testList.length; i++) {
          var testDataObj = testList[i];

          upComingList.add(upcomingTestModel(testDataObj["id"].toString(), testDataObj["TestName"].toString(),
            testDataObj["Level"].toString(), testDataObj["Image"].toString(),  testDataObj["StartDate"].toString(),
            testDataObj["Status"].toString(), testDataObj["Time"].toString(), testDataObj["Start_Time"].toString(),
            testDataObj["End_Time"].toString(),testDataObj["TestDuration"].toString(),testDataObj["testStatus"].toString(),
              testDataObj['questions']));
        }

        /*  resultList  */
        for (var i = 0; i < resultList.length; i++) {
          var resultDataObj = resultList[i];

          testResultsList.add(testResultModel(resultDataObj["id"].toString(), resultDataObj["Student_Id"].toString(),
              resultDataObj["Test_Id"].toString(), resultDataObj["testName"].toString(), resultDataObj["Student_Type"].toString(),
              resultDataObj["Level"].toString(), resultDataObj["Anwsers"].toString(), resultDataObj["TotalQuestion"].toString(),
              resultDataObj["TotalMarks"].toString(),resultDataObj["StudentMarks"].toString(), resultDataObj['Marks'].toString(),
              resultDataObj['Test_Status'].toString()));
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

