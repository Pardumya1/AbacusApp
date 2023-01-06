import 'dart:convert';
import 'package:abacus_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorProfile extends StatefulWidget {
  static const String routeName = '/TutorProfile';
  @override
  State<StatefulWidget> createState() => _TutorProfile();
}

class _TutorProfile extends State<TutorProfile> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController centreController = TextEditingController();


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
                statusBarBrightness: Brightness.light
            ),
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

            // actions: <Widget>[
            //   IconButton(icon: Image.asset('images/account_edit.png', height: 25), onPressed: () {
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => EditAccount(),
              //   ),
              // );
            //   }
            //   ),
            // ],
            titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body:  buildBody(),
        ),

      ],
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
          future: profileGetDataFunction(),
          builder: (context, snapshot){

            if(snapshot.connectionState == ConnectionState.done){
              return Column(
                children: <Widget>[

                  userImage(),
                  inputFields(),

                ],
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

          }
      ),
    );

  }

  userImage() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: CircleAvatar(
        radius: 45,
        backgroundColor: const Color(0xFF3A513B),
        child: Padding(
          padding: const EdgeInsets.all(4), // Border radius
          child: ClipOval(child: Image.asset(
              'images/user_image.png'
          )),
        ),
      )

    );
  }

  inputFields() {
    return
      Form(
        key: _formKey,
        child: Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  /*      Name Field     */
                  Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                      child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                          child: TextFormField(
                            autofocus: false,
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            controller:nameController,
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'images/name_icon.png',
                                    width: 10,
                                    height: 10,
                                    color: const Color(0xFF657269),
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                                border: InputBorder.none,
                                labelStyle: const TextStyle(
                                    color: Color(0xFF424943), fontSize: 14, fontFamily: "Montserrat")),
                          ),
                        ),
                      )),

                  /*      Email Field    */
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                          child: TextFormField(
                            autofocus: false,
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            controller:emailController,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'images/email_icon.png',
                                  width: 10,
                                  height: 10,
                                  color: const Color(0xFF657269),
                                  // fit: BoxFit.fill,
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )),

                  /*      Phone Number Field      */
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                          child: TextFormField(
                            autofocus: false,
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            controller:phoneController,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'images/call_icon.png',
                                  width: 10,
                                  height: 10,
                                  color: const Color(0xFF657269),
                                  // fit: BoxFit.fill,
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )),

                  /*      Center Name Field       */
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                          child: TextFormField(
                            autofocus: false,
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            controller:centreController,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'images/institute_icon.png',
                                  width: 10,
                                  height: 10,
                                  color: const Color(0xFF657269),
                                  // fit: BoxFit.fill,
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )),

                  /*      Address     */
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                      child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                          child: TextFormField(
                            autofocus: false,
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            controller:addressController,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'images/address_icon.png',
                                  width: 10,
                                  height: 10,
                                  color: const Color(0xFF657269),
                                  // fit: BoxFit.fill,
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
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

    try{
      Response response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.tutorProfileEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
          body: {
            'tutor_id' : prefs.getString(ApiConstants.tutorID),
          }
      );

      Map<String, dynamic> data = json.decode(response.body);
      debugPrint("Data : $data");


      if (data['status'] == "true") {

        Map<String, dynamic> dataObj = data["data"];

        nameController.text = dataObj['Name'];
        emailController.text = dataObj['Email'];
        phoneController.text = dataObj['Phone_number'];
        addressController.text = dataObj['Address'];
        centreController.text = dataObj['Franchisee_Name'];

      }
      else {
        Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }

    }catch(e){
      debugPrint("Error : $e");

    }

  }

}

