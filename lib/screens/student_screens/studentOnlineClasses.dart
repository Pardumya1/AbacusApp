import 'dart:convert';
import 'package:abacus_app/screens/student_screens/OnlineClassesPayment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import 'model/coursesListModel.dart';

class studentOnlineClass extends StatefulWidget {
  static const String routeName = '/studentOnlineClass';
  @override
  State<StatefulWidget> createState() => _studentOnlineClass();
}

class _studentOnlineClass extends State<studentOnlineClass> {

  List<coursesListModel> courseList = [];
  String studentName = "";
  String studentEmail = "";
  String studentPhone = "";

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

    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light
          ),
          title: const Text("Online Classes"),
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
              ),
            ),

          ),

          titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: "Montserrat"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: buildBody()

    );

  }


  Widget buildBody() {
    return SizedBox(
      //height: 800,
      width: double.infinity,
      child: Container(
          margin: const EdgeInsets.all(0),

          child: Stack(
              children: [
                const Image(
                    image: AssetImage("images/home_bg.png"),
                    fit: BoxFit.fill),

                showContent(),

              ]

          )
      ),
    );
  }

  showContent() {
    return SafeArea(
        child: FutureBuilder(
            future: studentOnlineClassDataFunction(),
            builder: (context, snapshot){

              if(snapshot.connectionState == ConnectionState.done){
                return courseList.isNotEmpty ? ListView.builder(
                  itemCount: courseList.length,
                  itemBuilder: (context, position) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                      child: GestureDetector(

                          child: leftData(position),
                          onTap: () =>

                          courseList[position].Status == "1" ?

                          Fluttertoast.showToast(
                            msg: "You have already subscribed to this course",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                          ) : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnlineClassesPayment(
                                mode : courseList[position].LearningType,
                                  courseID : courseList[position].courseID,
                                  courseTitle : courseList[position].courseName,
                                  courseDescription : courseList[position].courseDescription,
                                  expireDate : courseList[position].ExpiryDate,
                                  courseAmount : courseList[position].Price,
                              studentName : studentName,
                              studentEmail : studentEmail,
                              studentPhone : studentPhone,),
                            ),
                          )

                      ),
                    );
                  },
                ) : const Center(
                  child: Text("No Courses Found!",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        color: Colors.black),
                  ),
                );
              }
              else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

            })
    );

  }

  leftData(int position){
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),

      child: Container(
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
                image: AssetImage("images/bg_orange.png"),
                fit: BoxFit.cover)
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /*    Course Learning Type     */
            Container(
                alignment: Alignment.topLeft,
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      image: AssetImage("images/yellow_banner.png"),
                      fit: BoxFit.cover,
                    )
                ),

                padding: const EdgeInsets.only(top: 10, left: 5, right: 40, bottom: 10),

                child: Text("${courseList[position].LearningType} (${courseList[position].Level})",
                  style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      color: Colors.black),
                )
            ),

            /*    Course Name   */
            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: Text(courseList[position].courseName,
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Montserrat",
                    color: Colors.white),
              ),
            ),

            /*    Course Description  */
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(courseList[position].courseDescription,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    color: Colors.white),
              ),
            ),

            /*    Course More Detail  */
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Text("Start Date : ${courseList[position].StartDate}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    color: Colors.white),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Text("End Date : ${courseList[position].ExpiryDate}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    color: Colors.white),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Text("Course Amount : ${courseList[position].Price}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    color: Colors.white),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
                  child: Text("Course Duration : ${courseList[position].CourseDuration} minutes",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        color: Colors.white),
                  ),
                ),

                courseList[position].Status == "1" ?
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Icons.check_box,
                    color: Colors.white,
                  ),
                ) : Container()

              ]),

          ],
        ),
      ),
    );
  }

  /*      Api      */
  Future<void> studentOnlineClassDataFunction() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentName = prefs.getString(ApiConstants.studentName).toString();
    studentEmail = prefs.getString(ApiConstants.studentEmail).toString();
    studentPhone = prefs.getString(ApiConstants.studentPhoneNumber).toString();

    debugPrint("Bearer : ${prefs.getString(ApiConstants.accessTokenSP)}");


    try{
      Response response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.coursesListEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
          body: {
            // 'FranchiseeCode' : prefs.getString(ApiConstants.franchiseeCode),
            'FranchiseeCode' : "IPA/FRN/00305/15-16",
            'student_id' : prefs.getString(ApiConstants.studentID),
            'student_type' : prefs.getString(ApiConstants.studentLoginType),
            'learning_mode' : prefs.getString(ApiConstants.studentMode),

          }
      );

      Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == "true") {

        courseList.clear();
        var profileData = data['data'] as List;

        for (var i = 0; i < profileData.length; i++) {

          var profileDataObj = profileData[i];

          courseList.add(coursesListModel(profileDataObj['course_id'], profileDataObj['CourseName'],
              profileDataObj['CourseDescription'], profileDataObj['Standard'], profileDataObj['Level'],
              profileDataObj['CourseDuration'], profileDataObj['enrolStatus'], profileDataObj['Price'],
              profileDataObj['StartDate'], profileDataObj['ExpiryDate'], profileDataObj['LearningType'],
              profileDataObj['CourseImage']));

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


