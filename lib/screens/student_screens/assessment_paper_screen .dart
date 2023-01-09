
import 'dart:convert';

import 'package:abacus_app/screens/student_screens/wigets/assessment_cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../marge_screens/PDFScreen.dart';
import 'model/assessmentPaperListModel.dart';


class AssessmentPaperScreen extends StatefulWidget {

  static const String routeName = '/AssessmentPaperScreen';
  const AssessmentPaperScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AssessmentPaperScreen();

}

class _AssessmentPaperScreen extends State<AssessmentPaperScreen> {

  List<assessmentPaperListModel> paperList = [];

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
                title: const Text('Level Assessment Paper'),
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
                    Tab(text: "Assessment Paper"),
                    Tab(text: "Submitted Paper")
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


  /*      show Content    */
  showContent() {

    return SafeArea(
        child: FutureBuilder(
            future: getDataFunction(),
            builder: (context, snapshot){

              if(snapshot.connectionState == ConnectionState.done){
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F0F0),
                    border: Border.all(
                      color: const Color(0xBBFAFAFA),
                    ),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),

                  ),
                  child:TabBarView(
                    children: [
                      listViewSection(),
                      listViewSection(),
                    ],
                  ),
                );
              }else{
                return const Center(child: CircularProgressIndicator());
              }

            })
    );

  }

  listViewSection(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: paperList.length,
        itemBuilder: (context, index) {
          final post = paperList[index];
          return AssessmentCellWidget(
              id: post.id,
              title: post.AssPaperName,
              level: post.Level,
              pdf: post.UploadPDF,
              onClick: () {

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PDFScreen(),
                  ),
                );


              });
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }


  /*   get Assessment Details APIs     */
  Future<void> getDataFunction() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try{
      final response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.levelAssessmentPaperEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
          body: {
            'student_id' : prefs.getString(ApiConstants.studentID),
            'student_type' : prefs.getString(ApiConstants.studentLoginType),
            'level_code' : 'EL-02',
          }
      );

      Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == "true") {

        var paperListArray = data['data'] as List;
        paperList.clear();


        /*   levelList   */
        for (var i = 0; i < paperListArray.length; i++) {
          var paperDataObj = paperListArray[i];

          paperList.add(assessmentPaperListModel(paperDataObj["id"].toString(), paperDataObj["AssPaperName"].toString(),
              paperDataObj["Level"].toString(), paperDataObj["Status"].toString(),  paperDataObj["UploadPDF"].toString(),));

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

