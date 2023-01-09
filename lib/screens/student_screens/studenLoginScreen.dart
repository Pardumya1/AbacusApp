import 'dart:convert';

import 'package:abacus_app/screens/student_screens/studentIPASignup.dart';
import 'package:abacus_app/screens/student_screens/studentNewSignup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../student_screens/studentHome.dart';
import '../../utils/constants.dart';
import '../student_screens/forgot_password.dart';


class LoginStudent extends StatefulWidget {

  static const String routeName = '/LoginStudent';
  final String loginType;
  final String loginTypeName;

  const LoginStudent({Key? key, required this.loginType, required this.loginTypeName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginStudentState();

}

class _LoginStudentState extends State<LoginStudent> with SingleTickerProviderStateMixin{

  final _newFormKey = GlobalKey<FormState>();
  final _ipaFormKey = GlobalKey<FormState>();

  final emailFocus = FocusNode();
  final pwdFocus = FocusNode();

  final ipaRollNumberFocus = FocusNode();
  final ipaPwdFocus = FocusNode();


  final TextEditingController ipaRollNumberController = TextEditingController();
  final TextEditingController ipaPasswordController = TextEditingController();

  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();


  bool _showPassword = true;
  bool _ipaShowPassword = true;
  String emailVal = "";
  String passwordVal = "";
  String ipaRollNumberVal = "";
  String ipaPasswordVal = "";
  String screenNameVal = "";
  String screenTypeVal = "";

  late TabController _tabController;


  @override
  void initState() {
    super.initState();

    screenNameVal = widget.loginTypeName;
    screenTypeVal = widget.loginType;

    _tabController = TabController(length: 2, vsync: this);

  }


  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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


                    Container(

                      height: 50,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF063464),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        border: Border.all(
                          color: const Color(0x1A000000),
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        // give the indicator a decoration (color and border radius)
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.white,
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.white,
                        tabs: const [

                          Tab(
                            text: 'New Students',
                          ),

                          Tab(
                            text: 'IPA Students',
                          ),

                        ],
                      ),

                    ),

                    // tab bar view here
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [

                          // first tab bar view widget
                          Container(
                            child: newInputFields(screenNameVal, screenTypeVal),
                          ),

                          // second tab bar view widget
                          Container(
                            child: ipaInputFields(screenNameVal, screenTypeVal),
                          ),

                        ],
                      ),
                    ),

                  ],

                )
            ),
          ),
        ),
      ],
    );

  }


  /*      EditText, Forgot Password, Login Button, Bottom SignUp Line Function       */
  newInputFields(String screenNameVal, String screenTypeVal) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());

    return Form(
      key: _newFormKey,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            /*    Email EditText Field       */
            Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 5.0),
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
                      controller:newEmailController,
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
                          controller: newPasswordController,
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ForgotPassword()));
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
                      backgroundColor: const Color(0xFF063464),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: const BorderSide(color: Color(0xFF063464))),
                      elevation: 6.0
                  ),
                  onPressed: (){

                    final isValid = _newFormKey.currentState!.validate();
                    if (!isValid) {
                      return;
                    }
                    _newFormKey.currentState!.save();

                    showLoaderDialog(context);
                    loginFunction(newEmailController.text, newPasswordController.text, "0");

                  },
                  child: const Text("Login", style: TextStyle(fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500))
              ),
            ),


            /*   Bottom Don't Have an Account Line Function Call     */
            widget.loginType == "0" ? createAccount(screenNameVal, screenTypeVal, "new") : Container()

          ],
        ),
      ),
    );

  }

  /*      EditText, Forgot Password, Login Button, Bottom SignUp Line Function       */
  ipaInputFields(String screenNameVal, String screenTypeVal) {

    return Form(
      key: _ipaFormKey,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /*    RollNo EditText Field       */
            Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 5.0),
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
                      focusNode: ipaRollNumberFocus,
                      controller:ipaRollNumberController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (val){

                        if (val!.isEmpty) {
                          return "Please enter roll-no";
                        }
                        else {
                          return null;
                        }

                      },
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(ipaPwdFocus);
                      },
                      onSaved: (val)=> ipaRollNumberVal = val!,
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
                          hintText: "RollNo",
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
                          focusNode: ipaPwdFocus,
                          controller: ipaPasswordController,
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
                            ipaPwdFocus.unfocus();
                          },
                          onSaved: (val)=> ipaPasswordVal = val!,
                          obscureText: !_ipaShowPassword,
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
                              icon: Icon(_ipaShowPassword ? Icons.visibility_outlined : Icons
                                  .visibility_off_outlined, color: const Color(
                                  0xFFACB7AE)),
                              onPressed: () {
                                setState(() => _ipaShowPassword = !_ipaShowPassword);
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
                    debugPrint("Forgot Password?");
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ForgotPassword()));
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
                      backgroundColor: const Color(0xFF063464),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: const BorderSide(color: Color(0xFF063464))),
                      elevation: 6.0
                  ),
                  onPressed: (){

                    final isValid = _ipaFormKey.currentState!.validate();
                    if (!isValid) {
                      return;
                    }
                    _ipaFormKey.currentState!.save();

                    showLoaderDialog(context);
                    loginFunction(ipaRollNumberController.text, ipaPasswordController.text, "1");
                  },
                  child: const Text("Login", style: TextStyle(fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500))
              ),
            ),

            /*   Bottom Don't Have an Account Line Function Call     */
            widget.loginType == "0" ? createAccount(screenNameVal, screenTypeVal, "ipa") : Container()

          ],
        ),
      ),
    );

  }

  /*      Login Student Api Function        */
  void loginFunction(email, password, studentType) async {

    String userParamName = "";

    if(studentType == "0"){
      userParamName = "email";
    }else{
      userParamName = "roll_no";
    }

    try{
      Response response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.studentLoginEndpoint),
          body: {
            userParamName : email,
            'password' : password,
            'device_token' : 'Hello',
            'device_type' : defaultTargetPlatform == TargetPlatform.android ? '0': '1',
            'student_type' : studentType,
          }
      );

      Navigator.pop(context);
      Map<String, dynamic> dataObj = json.decode(response.body);
      debugPrint("dataObj : $dataObj");

      if(dataObj['status'] == "true"){

        addStringToSF(ApiConstants.accessTokenSP, dataObj['token'].toString());
        Map<String, dynamic> data = dataObj["data"];

        if(studentType == "0"){
          addStringToSF(ApiConstants.studentName, data["name"].toString());
          addStringToSF(ApiConstants.studentEmail, data["email"].toString());
          addStringToSF(ApiConstants.studentStandard, data["standard"].toString());
          addStringToSF(ApiConstants.studentGender, data["gender"].toString());
          addStringToSF(ApiConstants.studentDOB, data["date_of_birth"].toString());
          addStringToSF(ApiConstants.studentAddress, data["address"].toString());
          addStringToSF(ApiConstants.studentMode, data["mode"].toString());
          addStringToSF(ApiConstants.studentPhoneNumber, data["phone_number"].toString());
          addStringToSF(ApiConstants.studentDeviceToken, data["device_token"].toString());
          addStringToSF(ApiConstants.studentDeviceType, data["device_type"].toString());
          addStringToSF(ApiConstants.studentTerm, data["level"].toString());
          addStringToSF(ApiConstants.studentID, data["id"].toString());
          addStringToSF(ApiConstants.loginType, "0");
          addStringToSF(ApiConstants.studentLoginType, "0");
        }
        else{
          addStringToSF(ApiConstants.studentName, data["SNAME"].toString());
          addStringToSF(ApiConstants.studentEmail, data["MMAIL"].toString());
          addStringToSF(ApiConstants.studentStandard, data["SSTANDARD"].toString());
          addStringToSF(ApiConstants.studentGender, data["SSEX"].toString());
          addStringToSF(ApiConstants.studentDOB, data["SDOB"].toString());
          addStringToSF(ApiConstants.studentAddress, data["ORESIADD"].toString());
          addStringToSF(ApiConstants.studentMode, data["MODE"].toString());
          addStringToSF(ApiConstants.studentPhoneNumber, data["FTEL"].toString());
          addStringToSF(ApiConstants.studentDeviceToken, data["device_token"].toString());
          addStringToSF(ApiConstants.studentDeviceType, data["device_type"].toString());
          addStringToSF(ApiConstants.studentID, data["id"].toString());
          addStringToSF(ApiConstants.studentCode, data["STUDCODE"].toString());
          addStringToSF(ApiConstants.studentRollNo, data["SROLLNO"].toString());
          addStringToSF(ApiConstants.studentAge, data["SAGE"].toString());
          addStringToSF(ApiConstants.studentDOJ, data["SDOJ"].toString());
          addStringToSF(ApiConstants.studentDOC, data["SDOC"].toString());
          addStringToSF(ApiConstants.studentScheme, data["SSCHEME"].toString());
          addStringToSF(ApiConstants.studentTerm, data["STERM"].toString());
          addStringToSF(ApiConstants.studentSchool, data["SSCHOOL"].toString());
          addStringToSF(ApiConstants.franchiseeCode, data["FIntCode"].toString());
          addStringToSF(ApiConstants.loginType, "0");
          addStringToSF(ApiConstants.studentLoginType, "1");
        }

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => const StudentHome()));

      }
      else {
        Fluttertoast.showToast(
            msg: dataObj['message'],
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

  /*      Bottom Don't Have an Account Line Function   */
  createAccount(String screenNameVal, String screenTypeVal, String type) {

    return Container(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF999999),
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => type == "new" ? Signup(screenNameVal: screenNameVal, screenTypeVal: screenTypeVal):studentIPASignup(screenNameVal: screenNameVal, screenTypeVal: screenTypeVal),
            ),
          );
        },
      ),
    );
  }

  /*      Shared Preferences     */
  addStringToSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

}
