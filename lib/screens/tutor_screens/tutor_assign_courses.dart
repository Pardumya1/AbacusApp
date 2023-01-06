
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import 'model/assignCourseListModel.dart';

class TutorAssignCourses extends StatefulWidget {
  static const String routeName = '/TutorAssignCourses';

  const TutorAssignCourses({super.key});

  @override
  State<StatefulWidget> createState() => _TutorAssignCourses();
}

class _TutorAssignCourses extends State<TutorAssignCourses> {

  List<assignCourseListModel> assignCourseList = [];

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
            statusBarIconBrightness: Brightness.light
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
          title: const Text("Assign Courses List"),
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
          future: assignCoursesDataFunction(),
          builder: (context, snapshot){

            if(snapshot.connectionState == ConnectionState.done){
              return assignCourseList.isNotEmpty ? ListView.builder(
                itemCount: assignCourseList.length,
                itemBuilder: (context, position) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                    child: GestureDetector(
                        child: leftData(position)
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

                child: Text("${assignCourseList[position].LearningType} (${assignCourseList[position].Level})",
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
              child: Text(assignCourseList[position].Coursename,
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
              child: Text(assignCourseList[position].CourseDescription,
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
              child: Text("Assign Days : ${assignCourseList[position].Days}",
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
              child: Text("Expire Date : ${assignCourseList[position].ExpiryDate}",
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
              child: Text("Course Amount : ${assignCourseList[position].Price}",
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
              margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
              child: Text("Course Duration : ${assignCourseList[position].CourseDuration} minutes",
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

          ],
        ),
      ),
    );
  }


  /*        API       */
  Future<void> assignCoursesDataFunction() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try{
      Response response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.tutorAssignedCoursesEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
          body: {
            'tutor_id' : prefs.getString(ApiConstants.tutorID),
            // 'tutor_id' : "6",
          }
      );


      debugPrint("Auth : ${prefs.getString(ApiConstants.accessTokenSP)}");
      debugPrint("TutorID : ${prefs.getString(ApiConstants.tutorID)}");


      Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == "true") {

        assignCourseList.clear();
        var profileData = data['data'];

        for (var i = 0; i < profileData.length; i++) {
          var profileDataObj = profileData[i];

          debugPrint("profileDataObj : $profileDataObj");

          assignCourseList.add(assignCourseListModel(profileDataObj['id'], profileDataObj['Tutor_id'],
            profileDataObj['FranchiseeCode'], profileDataObj['FranchiseeName'], profileDataObj['TeacherName'],
            profileDataObj['Standard'], profileDataObj['Course_id'], profileDataObj['Course'],
            profileDataObj['Days'], profileDataObj['Time'], profileDataObj['Start_time'],
            profileDataObj['End_time'], profileDataObj['Coursename'],
            profileDataObj['CourseDescription'], profileDataObj['courses_standard'],
            profileDataObj['Level'], profileDataObj['CourseDuration'], profileDataObj['Status'],
            profileDataObj['Price'], profileDataObj['StartDate'], profileDataObj['ExpiryDate'],
            profileDataObj['LearningType'], profileDataObj['CourseImage'],
          ));
        }
      }
      else {
        // Fluttertoast.showToast(
        //   msg: data['message'],
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        // );
      }

    }catch(e){
      print("Error : $e");
    }

  }



}



