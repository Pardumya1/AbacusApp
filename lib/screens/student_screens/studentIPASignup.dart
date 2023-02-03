import 'dart:convert';

import 'package:abacus_app/screens/student_screens/model/getStudentRegisterDataModel.dart';
import 'package:abacus_app/screens/student_screens/studenLoginScreen.dart';
import 'package:abacus_app/screens/student_screens/studentHome.dart';
import 'package:abacus_app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class studentIPASignup extends StatefulWidget{
  static const String routeName = '/studentIPASignup';


  final String screenNameVal;
  final String screenTypeVal;

  const studentIPASignup({Key? key, required this.screenNameVal, required this.screenTypeVal}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _studentIPASignup();

}

class _studentIPASignup extends State<studentIPASignup> {


  /*     TextField      */
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController rollnoController = TextEditingController();

  final pwdFocus = FocusNode();
  final confirmPwdFocus = FocusNode();
  final rollnoFocus = FocusNode();


  bool isLoading= false;
  bool _showPassword = false;
  bool confirmPassword = false;

  late String passwordVal, confirmPasswordVal, rollnoVal;

  List<ModeModel> learningModesList = [];
  var currentSelectedLearningValue;

  String? studentType = "online";


  @override
  void initState() {
    super.initState();


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
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark
            ),
            title: const Text("Let's Get Started"),
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
          body:  Container(

            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.png"), fit: BoxFit.fill)),
            child: SafeArea(
              child: FutureBuilder(
                  future: registerGetDataFunction(),
                  builder: (context, snapshot){

                    return Column(
                      children: [

                        const Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text("Create an Account",
                                textAlign: TextAlign.center,
                                style: TextStyle(decoration: TextDecoration.none, fontSize: 14.0, color: Color(0xFF47473F), fontFamily: "Montserrat", fontWeight: FontWeight.w500)
                            )),

                        inputFields(),

                      ],
                    );

                  }

                  ),
            ),
          ),
        ),
      ],

    );
  }


  /*      All Field Function      */
  inputFields() {
    return
      Form(
        key: _formKey,
        child: Expanded(
          child: Container(
            // alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  /*    RollNo Field      */
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: const BorderSide(color: Colors.white),),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                        child: TextFormField(
                          autofocus: false,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(fontFamily: "Montserrat"),
                          focusNode: rollnoFocus,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          controller:rollnoController,
                          validator: (val){
                            if (val!.isEmpty) {
                              return "Please enter roll-no";
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (v){
                            FocusScope.of(context).requestFocus(pwdFocus);
                          },
                          onSaved: (val)=> rollnoVal =val!,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'images/call_icon.png',
                                  width: 10,
                                  height: 10,
                                  color: const Color(0xFF0F6027),
                                  // fit: BoxFit.fill,
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: "Roll-No",
                              hintStyle: const TextStyle(
                                  color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat")),
                        ),
                      ),
                    ),
                  ),

                  /*    Password Field   */
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(fontFamily: "Montserrat"),
                          focusNode: pwdFocus,
                          controller: _pass,
                          textInputAction: TextInputAction.next,
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
                          onSaved: (val)=> passwordVal =val!,
                          onFieldSubmitted: (v){
                            FocusScope.of(context).requestFocus(confirmPwdFocus);
                          },
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'images/pass_icon.png',
                                  width: 10,
                                  height: 10,
                                  color: const Color(0xFF0F6027),
                                  // fit: BoxFit.fill,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_showPassword ? Icons.visibility_outlined : Icons
                                    .visibility_off_outlined, color: const Color(0xFF424943)),
                                onPressed: () {
                                  setState(() => _showPassword = !_showPassword);
                                },
                              ),
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                  color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat")),
                        ),
                      ),
                    ),
                  ),

                  /*     Confirm Password Field  */
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(fontFamily: "Montserrat"),
                          focusNode: confirmPwdFocus,
                          controller: _confirmPass,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val){
                            if (val!.isEmpty) {
                              return "Please enter confirm password";
                            }
                            else if (val!= _pass.text) {
                              return "Not Match";
                            }
                            else {
                              return null;
                            }
                          },
                          onSaved: (val)=>confirmPasswordVal=val!,
                          obscureText: !confirmPassword,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'images/pass_icon.png',
                                  width: 10,
                                  height: 10,
                                  color: const Color(0xFF0F6027),
                                  // fit: BoxFit.fill,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_showPassword ? Icons.visibility_outlined : Icons
                                    .visibility_off_outlined, color: const Color(0xFF424943)),
                                onPressed: () {
                                  setState(() => confirmPassword = !confirmPassword);
                                },
                              ),
                              border: InputBorder.none,
                              hintText: "Confirm Password",
                              hintStyle: const TextStyle(
                                  color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat")),
                        ),
                      ),
                    ),
                  ),

                  /*    Select Mode Drop Down      */
                  Container(
                    height: 50,
                    alignment : Alignment.center,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),

                        child: dropDownLearning()
                    ),
                  ),

                  /*      Student Type     */
                  Container(
                    alignment : Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 15,),
                    child: const Text("Student Type", style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        color: Colors.black)),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: const BorderSide(color: Colors.white)),
                      child: Row(
                          children: [

                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: RadioListTile(
                                title: const Text("Online Student"),
                                value: "online",
                                groupValue: studentType,
                                onChanged: (value){
                                  setState(() {
                                    studentType = value.toString();
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: RadioListTile(
                                title: const Text("Offline Student"),
                                value: "offline",
                                groupValue: studentType,
                                onChanged: (value){
                                  setState(() {
                                    studentType = value.toString();
                                  });
                                },
                              ),

                            ),

                          ]),
                    ),
                  ),


                  /*     Create Button     */
                  Container(
                    margin: const EdgeInsets.only(top: 20,bottom: 10, left: 0, right: 0),
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
                        onPressed: () {

                          final isValid = _formKey.currentState!.validate();
                          if (!isValid) {
                            return;
                          }
                          _formKey.currentState!.save();

                          if(currentSelectedLearningValue == null){

                            Fluttertoast.showToast(
                              msg: "Please select learning mode",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                            );

                          }
                          else{
                            showLoaderDialog(context);
                            registerFunction();
                          }

                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                              fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white),
                        )
                    ),
                  ),

                  createAccount()


                ],
              ),
            ),
          ),
        ),

      );
  }

  /*      Progress Bar      */
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }


  /*      Select Live Mode DropDown Functions   */
  dropDownLearning() {
    return Stack(
      children: <Widget>[
        dropDownLearningImg(),
        dropDownMode()

      ],

    );
  }

  dropDownMode() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child:  Padding(
              padding: const EdgeInsets.only(
                  left: 48.0,
                  right: 5.0),
              child: FormField<dynamic>(
                builder: (FormFieldState<dynamic> state) {
                  return InputDecorator(
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text("Select Mode"),
                        dropdownColor: Colors.white,
                        value: currentSelectedLearningValue,
                        isDense: true,
                        onChanged: (newValue) {

                          setState(() {
                            currentSelectedLearningValue = newValue.toString();
                          });

                        },

                        items: learningModesList.map((map) =>
                            DropdownMenuItem(
                              value: map.id,
                              child: Text(map.name),
                            ),
                        ).toList(),

                      ),
                    ),
                  );
                },
              ),
            ),


          ),
        ),

      ],

    );
  }

  dropDownLearningImg() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'images/learning_icon.png',
                width: 21,
                height: 21,
                color: const Color(0xFF0F6027),
                // fit: BoxFit.fill,
              ),
            ),

          ),
        ),

      ],

    );
  }


  /*      Bottom Line Function    */
  createAccount() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        style: TextButton.styleFrom(
          //  32 foregroundColor: const Color(0xFF999999),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            text: "Already have an Account? ",
            style: TextStyle(color: Color(0xFF463D3D), fontSize: 14, fontFamily: "Montserrat", fontWeight: FontWeight.w600),
            children: <TextSpan>[
              TextSpan(text: 'Login', style: TextStyle(color: Color(0xFF156CC4))),
            ],
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => const LoginStudent(loginType: '0',loginTypeName:"Student")));
        },
      ),
    );
  }



  /*    Get Function Api       */
  Future<void> registerGetDataFunction() async {

    try{

      final response = await get(Uri.parse(ApiConstants.baseUrl + ApiConstants.studentGetRegisterDataEndpoint));
      var data = jsonDecode(response.body.toString());

      if (data['status'] == "true") {

        var mode_data = data['mode'] as List;
        debugPrint("mode_data : $mode_data");

        learningModesList.clear();


        /*   mode_data   */
        for (var i = 0; i < mode_data.length; i++) {
          var mode_data_obj = mode_data[i];
          learningModesList.add(ModeModel(mode_data_obj["id"].toString(), mode_data_obj["name"]));
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

  /*    Register Student Function        */
  void registerFunction() async {

    try{

      Response response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.usersIPARegisterEndpoint),
          body: {

            'roll_no' : rollnoController.text,
            'password' : _pass.text,
            'mode' : currentSelectedLearningValue,
            'device_token' : 'Hello',
            'device_type' : defaultTargetPlatform == TargetPlatform.android ? '0': '1',
            'studentType' : studentType,

          }
      );

      Navigator.pop(context);
      Map<String, dynamic> dataObj = json.decode(response.body);
      addStringToSF(ApiConstants.accessTokenSP, dataObj['token'].toString());
      debugPrint("dataObj : $dataObj");

      if(dataObj['status'] == "true"){

        Map<String, dynamic> data = dataObj["data"];
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

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => StudentHome()));

      }
      else {

        Fluttertoast.showToast(
          msg: dataObj['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );

      }

    }catch(e){
      // Navigator.pop(context);
      print("Error : $e");
    }
  }


  /*      SharedPreferences Function   */
  addStringToSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }



}

