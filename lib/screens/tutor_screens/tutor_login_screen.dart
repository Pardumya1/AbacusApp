import 'dart:convert';

import 'package:abacus_app/screens/student_screens/studentNewSignup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../student_screens/studentHome.dart';
import 'TutorHomeScreen.dart';
import '../../utils/constants.dart';
import '../student_screens/forgot_password.dart';
import '../marge_screens/signup_marge.dart';


class TutorLoginScreen extends StatefulWidget {

  static const String routeName = '/Login';
  final String loginType;
  final String loginTypeName;

  const TutorLoginScreen({Key? key, required this.loginType, required this.loginTypeName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TutorLoginScreen();

}

class _TutorLoginScreen extends State<TutorLoginScreen> with SingleTickerProviderStateMixin{

  final _formKey = GlobalKey<FormState>();
  final emailFocus = FocusNode();
  final pwdFocus = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showPassword = true;
  String emailVal = "";
  String passwordVal = "";
  String screenNameVal = "";
  String screenTypeVal = "";



  @override
  void initState() {
    super.initState();

    screenNameVal = widget.loginTypeName;
    screenTypeVal = widget.loginType;

    // addStringToSF(screenTypeVal);

  }


  @override
  void dispose() {
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark
            ),
            title: Text("Welcome $screenNameVal"),
            leading: IconButton(
              onPressed: () {

                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
                // Navigator.pop(context);

              },
              icon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'images/back.png',
                  width: 14,
                  height: 14,

                  // fit: BoxFit.fill,
                ),
              ),
            ),
            titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Color(0xFF47473F), fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(

            decoration: const BoxDecoration(image: DecorationImage(
              image: AssetImage("images/login_image.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),),

            child: SafeArea(
                child: Column(

                  children: [
                    const Text("Log in to continue",
                      textAlign: TextAlign.center,
                      style: TextStyle(decoration: TextDecoration.none, fontSize: 14.0, color: Color(0xFF47473F), fontFamily: "Montserrat", fontWeight: FontWeight.w500),),


                    /*    Call Function  */
                    inputFields(screenNameVal, screenTypeVal) ,

                  ],

                )
            ),
          ),
        ),
      ],
    );

  }


  /*      EditText, Forgot Password, Login Button, Bottom SignUp Line Function       */
  inputFields(String screenNameVal, String screenTypeVal) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());

    return Form(
      key: _formKey,
      child: Expanded(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /*    Email EditText Field       */
              Padding(
                  padding: const EdgeInsets.only(top: 120.0, bottom: 5.0),
                  child: Material(
                    elevation: 1.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: const BorderSide(color: Color(0xFFEEEEE9))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                      child: TextFormField(
                        style: const TextStyle(fontFamily: "Montserrat"),
                        autofocus: false,
                        textAlignVertical: TextAlignVertical.center,
                        focusNode: emailFocus,
                        controller:emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val){

                          if (val!.isEmpty) {
                            return "Please enter email";
                          }
                          else if (!regex.hasMatch(val)) {
                            return "Please enter valid email";
                          }
                          else {
                            return null;
                          }

                        },
                        onFieldSubmitted: (v){
                          FocusScope.of(context).requestFocus(pwdFocus);
                        },
                        onSaved: (val)=> emailVal = val!,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'images/email_icon.png',
                                width: 10,
                                height: 10,
                                color: const Color(0xFF0F6027),
                                // fit: BoxFit.fill,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: const TextStyle(
                                color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat")),

                      ),
                    ),
                  )),

              /*    Password EditText Field    */
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Material(
                  elevation: 1.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: const BorderSide(color: Colors.white)),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                      child: Column(
                        children: [
                          TextFormField(
                            style: const TextStyle(fontFamily: "Montserrat"),
                            autofocus: false,
                            textAlignVertical: TextAlignVertical.center,
                            focusNode: pwdFocus,
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Please enter password";
                              } else if (val.length <= 4) {
                                return "Your password should be more then 5 char long";
                              } else {
                                return null;
                              }
                            },
                            onFieldSubmitted: (v){
                              pwdFocus.unfocus();
                            },
                            onSaved: (val)=> passwordVal = val!,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'images/pass_icon.png',
                                  width: 15,
                                  height: 15,
                                  color: const Color(0xFF0F6027),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_showPassword ? Icons.visibility_outlined : Icons
                                    .visibility_off_outlined, color: const Color(
                                    0xFFACB7AE)),
                                onPressed: () {
                                  setState(() => _showPassword = !_showPassword);
                                },
                              ),
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                  color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat"),
                            ),

                          ),
                        ],
                      )
                  ),
                ),
              ),

              /*    Forgot Password          */
              Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    child:  const Text(
                      "Forgot Password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 14.0,
                          color: Color(0xFFA4A49F),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const ForgotPassword()));
                    },
                  )
              ),

              /*    Login Button      */
              Container(
                margin: const EdgeInsets.only(top: 50,bottom: 10),
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //  32 backgroundColor: const Color(0xFF063464),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Color(0xFF063464))),
                        elevation: 6.0
                    ),
                    onPressed: (){

                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      _formKey.currentState!.save();

                      loginFunction(emailController.text, passwordController.text);

                    },
                    child: const Text("Login", style: TextStyle(fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500))
                ),
              ),

              /*   Bottom Don't Have an Account Line Function Call     */
              widget.loginType == "0" ? createAccount(screenNameVal, screenTypeVal) : Container()

            ],
          ),
        ),
      ),
    );

  }


  /*      Login Student Function        */
  void loginFunction(String email , password) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    showLoaderDialog(context);
    try{
      Response response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.loginTutorEndpoint),
          body: {
            'Email' : email,
            'Password' : password,
            'Device_token' : 'hello',
            'Device_type' : defaultTargetPlatform == TargetPlatform.android ? '0': '1',
          }
      );

      var tutorData = jsonDecode(response.body.toString());


      if(tutorData['status'] == "true"){

        Navigator.pop(context);

        addStringToSF(ApiConstants.accessTokenSP, tutorData['token'].toString());
        Map<String, dynamic> data = tutorData["data"];
        debugPrint("Data : ${data['id']}");

        addStringToSF(ApiConstants.tutorID, data['id'].toString());
        addStringToSF(ApiConstants.tutorName, data['Name'].toString());
        addStringToSF(ApiConstants.tutorEmail, data['Email'].toString());
        addStringToSF(ApiConstants.tutorPhoneNumber, data['Phone_number'].toString());
        addStringToSF(ApiConstants.tutorAddress, data['Address'].toString());
        addStringToSF(ApiConstants.tutorDeviceToken, data['Device_token'].toString());
        addStringToSF(ApiConstants.tutorDeviceType, data['Device_type'].toString());
        addStringToSF(ApiConstants.tutorTutorImage, data['TutorImage'].toString());
        addStringToSF(ApiConstants.tutorFranchiseeName, data['Franchisee_Name'].toString());
        addStringToSF(ApiConstants.loginType, "1");

        debugPrint("TutorIDData : ${data['id'].toString()}");
        debugPrint("TutorIDData : ${prefs.getString(ApiConstants.tutorID)}");

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => const TutorHome()));

      }
      else {

        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: tutorData['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
        );

      }
    }

    catch(e){
      // Navigator.pop(context);
      print("Error : $e");

    }

  }


  /*      Progress Bar    */
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }


  /*      Shared Preferences     */
  addStringToSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }


  /*      Bottom Don't Have an Account Line Function   */
  createAccount(String screenNameVal, String screenTypeVal) {

    return Container(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        style: TextButton.styleFrom(
          //  32 foregroundColor: const Color(0xFF999999),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            text: "Don't have an Account? ",
            style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: "Montserrat", fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(text: 'Signup', style: TextStyle(color: Color(0xFF156CC4))),
            ],
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.loginType == "0" ? Signup(screenNameVal: screenNameVal, screenTypeVal: screenTypeVal) : const SignupMargeScreen()),
          );
        },
      ),
    );
  }


}
