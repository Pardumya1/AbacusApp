import 'dart:convert';

import 'package:abacus_app/screens/student_screens/model/getStudentRegisterDataModel.dart';
import 'package:abacus_app/screens/student_screens/studenLoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../utils/constants.dart';
import 'studentHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class Signup extends StatefulWidget{
  static const String routeName = '/Signup';


  final String screenNameVal;
  final String screenTypeVal;

  const Signup({Key? key, required this.screenNameVal, required this.screenTypeVal}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Signup();

}

class _Signup extends State<Signup> {

  var currentSelectedLearningValue;
  var currentSelectedStandardValue;

  /*     TextField      */
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stdController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final pwdFocus = FocusNode();
  final confirmPwdFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final nameFocus = FocusNode();
  final stdFocus = FocusNode();
  final dobFocus = FocusNode();
  final addressFocus = FocusNode();

  List<ModeModel> learningModesList = [];
  List<StandardModel> standardList = [];
  bool isLoading = false;

  // Initially password is obscure
  bool _showPassword = false;
  bool confirmPassword = false;

  String? gender;

  late String fullNameVal, emailVal, passwordVal, confirmPasswordVal, phoneVal, stdVal, dobVal, addressVal, screenNameVal, screenTypeVal;


  @override
  void initState() {
    super.initState();

    screenNameVal = widget.screenNameVal;
    screenTypeVal = widget.screenTypeVal;


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
          body: Container(
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

                        /*    Create Button      */
                        Container(
                          margin: const EdgeInsets.only(top: 20,bottom: 10, left: 20, right: 20),
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
                              onPressed: () {

                                debugPrint('Name : ${nameController.text}'
                                    '\nEmail : ${emailController.text}'
                                    '\nStandard : ${stdController.text}'
                                    '\nDate Of Birth : ${dobController.text}'
                                    '\nAddress : ${addressController.text}'
                                    '\Gender : ${gender}'
                                    '\nContact Number : ${phoneController.text}'
                                    '\nPassword : ${_passController.text}'
                                    '\nConfirm Password : ${_confirmPassController.text}'
                                    '\nCurrent Selected Learning Value : $currentSelectedLearningValue'
                                    '\nCurrent Selected Standard Val ue : $currentSelectedStandardValue');


                                final isValid = _formKey.currentState!.validate();
                                if (!isValid) {
                                  return;
                                }

                                _formKey.currentState!.save();


                                if(_passController.text != _confirmPassController.text){
                                  Fluttertoast.showToast(
                                    msg: "Password and Confirm Password not match",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );
                                }
                                else if(currentSelectedStandardValue == null){
                                  Fluttertoast.showToast(
                                    msg: "Please select standard",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );
                                }
                                else if(dobController.text == ""){

                                  Fluttertoast.showToast(
                                    msg: "Please select date of birth",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );

                                }
                                else if(currentSelectedLearningValue == null){

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
                    );
                  },
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
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    /*    Name Field   */
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
                              focusNode: nameFocus,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(fontFamily: "Montserrat"),
                              controller:nameController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (val){
                                if (val!.isEmpty) {
                                  return "Please enter name";
                                } else if (val.length <3) {
                                  return "Name must be more than 2 charater";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val)=> fullNameVal = val!,
                              onFieldSubmitted: (v){
                                FocusScope.of(context).requestFocus(stdFocus);
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'images/name_icon.png',
                                      width: 10,
                                      height: 10,
                                      color: const Color(0xFF0F6027),
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Name",
                                  hintStyle: const TextStyle(
                                      color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat")),
                            ),
                          ),
                        )),

                    /*    Email Field   */
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
                          child: TextFormField(
                            autofocus: false,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            focusNode: emailFocus,
                            controller:emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Please enter email";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val)=> emailVal =val!,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(pwdFocus);
                            },
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
                      ),
                    ),

                    /*     Standard Field     */
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

                          child: dropDownMainStandard()
                      ),
                    ),

                    /*      Gender     */
                    Container(
                      alignment : Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 15,),
                      child: const Text("Gender", style: TextStyle(
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
                                title: Text("Male"),
                                value: "Male",
                                groupValue: gender,
                                onChanged: (value){
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                                child: RadioListTile(
                                title: Text("Female"),
                                value: "Female",
                                groupValue: gender,
                                onChanged: (value){
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),

                            ),

                          ]),
                      ),
                    ),

                    /*     Date Of Birth Field     */
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(

                          padding: const EdgeInsets.only(left: 10.0, right: 0.0),
                          child: TextField(
                            controller: dobController, //editing controller of this TextField
                            decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today, color: Color(0xFF0F6027), ), //icon of text field
                              labelText: "Date of Birth", //label text of field
                              border: InputBorder.none,
                            ),
                            readOnly: true,  //set it true, so that user will not able to edit text
                            onTap: () async {

                              DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(1000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101),

                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Color(0xFF063464), // <-- SEE HERE
                                        onPrimary: Colors.white, // <-- SEE HERE
                                        onSurface: Colors.black, // <-- SEE HERE
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.black, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if(pickedDate != null ){
                                print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  dobController.text = formattedDate; //set output date to TextField value.
                                });
                              }else{
                                print("Date is not selected");
                              }
                            },
                          ),

                        ),
                      ),
                    ),

                    /*     Address Field     */
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
                          child: TextFormField(
                            autofocus: false,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            focusNode: addressFocus,
                            controller:addressController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Please enter address";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val)=> addressVal =val!,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(phoneFocus);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'images/address_icon.png',
                                    width: 10,
                                    height: 10,
                                    color: const Color(0xFF0F6027),
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: "Address",
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

                    /*    Phone Number Field      */
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
                            focusNode: phoneFocus,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            controller:phoneController,
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Please enter phone number";
                              } else if (val.length != 10) {
                                return "phone Number must be of 10 digit";
                              } else {
                                return null;
                              }
                            },
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(emailFocus);
                            },
                            onSaved: (val)=> phoneVal =val!,
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
                                hintText: "Phone Number",
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
                            controller: _passController,
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
                            controller: _confirmPassController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Please enter confirm password";
                              }
                              else if (val!= _passController.text) {
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


                  ],
                ),
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


  /*      Select Standard DropDown Functions   */
  dropDownMainStandard() {
    return Stack(
      children: <Widget>[
        dropDownStandardImg(),
        dropDownStandard()

      ],

    );
  }

  dropDownStandard() {
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
                        hint: const Text("Select Standard"),
                        dropdownColor: Colors.white,
                        value: currentSelectedStandardValue,
                        isDense: true,
                        onChanged: (newValue) {

                          setState(() {
                            currentSelectedStandardValue = newValue.toString();
                          });

                        },

                        items: standardList.map((map) =>
                            DropdownMenuItem(
                              value: map.name,
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

  dropDownStandardImg() {
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
          foregroundColor: const Color(0xFF999999),
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


  /*      SharedPreferences Function   */
  addStringToSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }


  /*      Api Section Start   */

  /*    Register Student Function        */
  void registerFunction() async {

      try{

        Response response = await post(
            Uri.parse(ApiConstants.baseUrl + ApiConstants.usersNewRegisterEndpoint),
            body: {

              'name' : nameController.text,
              'email' : emailController.text,
              'standard' : currentSelectedStandardValue,
              'phone_number' : phoneController.text,
              'date_of_birth' : dobController.text,
              'address' : addressController.text,
              'mode' : currentSelectedLearningValue,
              'device_token' : 'Hello',
              'device_type' : defaultTargetPlatform == TargetPlatform.android ? '0': '1',
              'gender' : gender,
              'password' : _passController.text,

            }
        );

        Navigator.pop(context);
        Map<String, dynamic> dataObj = json.decode(response.body);
        addStringToSF(ApiConstants.accessTokenSP, dataObj['token'].toString());
        debugPrint("dataObj : $dataObj");

        if(dataObj['status'] == "true"){

          Map<String, dynamic> data = dataObj["data"];
          addStringToSF(ApiConstants.studentName, data["name"].toString());
          addStringToSF(ApiConstants.studentEmail, data["email"].toString());
          addStringToSF(ApiConstants.studentStandard, data["standard"].toString());
          addStringToSF(ApiConstants.studentGender, data["gender"].toString());
          addStringToSF(ApiConstants.studentDOB, data["date_of_birth"].toString());
          addStringToSF(ApiConstants.studentAddress, data["address"].toString());
          addStringToSF(ApiConstants.studentMode, data["mode"].toString());
          addStringToSF(ApiConstants.studentTerm, data["level"].toString());
          addStringToSF(ApiConstants.studentPhoneNumber, data["phone_number"].toString());
          addStringToSF(ApiConstants.studentDeviceToken, data["device_token"].toString());
          addStringToSF(ApiConstants.studentDeviceType, data["device_type"].toString());
          addStringToSF(ApiConstants.studentID, data["id"].toString());
          addStringToSF(ApiConstants.loginType, "0");
          addStringToSF(ApiConstants.studentLoginType, "0");

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

      }catch(e){
        // Navigator.pop(context);
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

