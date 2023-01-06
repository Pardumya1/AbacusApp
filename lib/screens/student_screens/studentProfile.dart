import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import 'edit_account.dart';
import 'model/getStudentRegisterDataModel.dart';

class StudentProfile extends StatefulWidget {
  static const String routeName = '/StudentProfile';
  final String studentLoginType;
  const StudentProfile({super.key, required this.studentLoginType});

  @override
  State<StatefulWidget> createState() => _StudentProfile();
}

class _StudentProfile extends State<StudentProfile>{

  String fullName = "",
      email = "",
      phone = "",
      std = "",
      gender = "",
      mode = "",
      dob = "",
      address = "",
      centreName = "",
      studentID = "";

  bool editStatus = false;

  List<ModeModel> learningModesList = [];
  List<StandardModel> standardList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

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
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light),
            title: const Text("My Account"),
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
                  // fit: BoxFit.fill,
                ),
              ),
            ),
            actions: <Widget>[
              widget.studentLoginType == "0" ? IconButton(
                  icon: Image.asset('images/account_edit.png', height: 25),
                  onPressed: () {

                    if(editStatus){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditAccount(fullName : fullName, email : email,
                                  phone : phone, std : std, gender : gender,
                                  mode : mode, dob : dob, address : address,
                                  learningModesList : learningModesList,
                                  standardList : standardList
                              ),
                        ),
                      );
                    }else{
                      Fluttertoast.showToast(
                        msg: "Loading....",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    }


                  }) : Container(),
            ],
            titleTextStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: buildBody(),
        ),
      ],
    );
  }

  Widget buildBody() {
    return SizedBox(
      //height: 800,
      width: double.infinity,
      child: Container(
          margin: EdgeInsets.all(0),
          child: Stack(children: [
            const Image(
                image: AssetImage("images/home_bg.png"), fit: BoxFit.fill),
            showContent(),
          ])),
    );
  }

  showContent() {
    return SafeArea(
      child: FutureBuilder(
          future: profileGetDataFunction(),
          builder: (context, snapshot){

            if(snapshot.connectionState == ConnectionState.done){
              return Column(
                children: <Widget>[
                  userImage(),
                  inputFields()
                ],
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

  userImage() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        child: CircleAvatar(
          radius: 45,
          backgroundColor: const Color(0xFF3A513B),
          child: Padding(
            padding: const EdgeInsets.all(4), // Border radius
            child: ClipOval(child: Image.asset('images/user_image.png')),
          ),
        ));
  }

  inputFields() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                /*    Name   */
                Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            children: [

                              const Image(
                                image: AssetImage("images/name_icon.png"),
                                height: 24,
                                color: Color(0xFF657269),
                              ),
                              Expanded(
                                  flex:1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      fullName,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey),
                                    ),
                                  ))

                            ]),
                      ),
                    )),

                /*    Email  */
                Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            children: [

                              const Image(
                                image: AssetImage("images/email_icon.png"),
                                height: 24,
                                color: Color(0xFF657269),
                              ),
                              Expanded(
                                  flex:1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      email,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey),
                                    ),
                                  ))

                            ]),
                      ),
                    )),

                /*    Phone Number   */
                Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            children: [
                              const Image(
                                image: AssetImage("images/call_icon.png"),
                                height: 24,
                                color: Color(0xFF657269),
                              ),

                              Expanded(
                                  flex:1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      phone,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey),
                                    ),
                                  ))

                            ]),
                      ),
                    )),

                /*   Centre Drop Down    */
                widget.studentLoginType == "1" ? Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            children: [

                              const Image(
                                image: AssetImage("images/institute_icon.png"),
                                height: 24,
                                color: Color(0xFF657269),
                              ),
                              Expanded(
                                  flex:1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      centreName,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey),
                                    ),
                                  ))

                            ]),
                      ),
                    )) : Container(),

                /*   Standard        */
                Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            children: [

                              const Image(
                                image: AssetImage("images/std_icon.png"),
                                height: 24,
                                color: Color(0xFF657269),
                              ),
                              Expanded(
                                  flex:1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "$std Standard",
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey),
                                    ),
                                  ))

                            ]),
                      ),
                    )),

                /*      Gender     */
                Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            children: [

                              const Image(
                                image: AssetImage("images/std_icon.png"),
                                height: 24,
                                color: Color(0xFF657269),
                              ),
                              Expanded(
                                  flex:1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      gender,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey),
                                    ),
                                  ))

                            ]),
                      ),
                    )),

                /*   Date of birth   */
                Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            children: [

                              const Image(
                                image: AssetImage("images/dob_icon.png"),
                                height: 24,
                                color: Color(0xFF657269),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      dob,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey),
                                    ),
                                  ))

                            ]),
                      ),
                    )),

                /*   Address         */
                Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            children: [
                              const Image(
                                image: AssetImage("images/address_icon.png"),
                                height: 24,
                                color: Color(0xFF657269),
                              ),

                              Expanded(
                                  flex :1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      address,
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey),
                                    ),
                                  )
                              )

                            ]),
                      ),
                    )),

                /*   Learning Mode   */
                Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            children: [

                              const Image(
                                image: AssetImage("images/mode_icon.png"),
                                height: 24,
                                color: Color(0xFF657269),
                              ),
                              Expanded(
                                  flex :1,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      mode == "1" ? "One on one class" : "Group class",
                                      style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 18,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey),
                                    ),
                                  ))

                            ]),
                      ),
                    )),

              ],
            ),
          ),
        ),
      ),
    );
  }

  /*    Get Function Api       */
  Future<void> profileGetDataFunction() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentID = prefs.getString(ApiConstants.studentID).toString();
    debugPrint("studentID : ${prefs.getString(ApiConstants.accessTokenSP)}");

    try{
      Response response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.studentProfileEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
          body: {
            'student_id' : prefs.getString(ApiConstants.studentID),
            'student_type' : prefs.getString(ApiConstants.studentLoginType),
          }
      );

      Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == "true") {

        var profileData = data['data'] as List;

        for (var i = 0; i < profileData.length; i++) {

          var profileDataObj = profileData[i];

          if(widget.studentLoginType == "0"){
            fullName = profileDataObj["name"].toString();
            email = profileDataObj["email"].toString();
            std = profileDataObj["standard"].toString();
            gender = profileDataObj["gender"].toString();
            dob = profileDataObj["date_of_birth"].toString();
            address = profileDataObj["address"].toString();
            mode =  profileDataObj["mode"].toString();
            phone = profileDataObj["phone_number"].toString();
          }
          else{
            fullName = profileDataObj["SNAME"].toString();
            email = profileDataObj["MMAIL"].toString();
            std = profileDataObj["SSTANDARD"].toString();
            gender = profileDataObj["SSEX"].toString();
            dob = profileDataObj["SDOB"].toString();
            centreName = profileDataObj["FNAME"].toString();
            address = profileDataObj["ORESIADD"].toString();
            mode =  profileDataObj["MODE"].toString();
            phone = profileDataObj["FTEL"].toString();

          }

          registerGetDataFunction();

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


  /*    Get Function Api       */
  Future<void> registerGetDataFunction() async {

    try{
      final response = await get(Uri.parse(ApiConstants.baseUrl + ApiConstants.studentGetRegisterDataEndpoint));
      var data = jsonDecode(response.body.toString());

      if (data['status'] == "true") {

        var standard_data = data['standard'] as List;
        var mode_data = data['mode'] as List;

        standardList.clear();
        learningModesList.clear();

        /*   standard_data   */
        for (var i = 0; i < standard_data.length; i++) {
          var standard_data_obj = standard_data[i];
          standardList.add(StandardModel(standard_data_obj["id"].toString(), standard_data_obj["Standard"]));
        }

        /*   mode_data   */
        for (var i = 0; i < mode_data.length; i++) {
          var mode_data_obj = mode_data[i];
          learningModesList.add(ModeModel(mode_data_obj["id"].toString(), mode_data_obj["name"]));
        }

        editStatus = true;

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
