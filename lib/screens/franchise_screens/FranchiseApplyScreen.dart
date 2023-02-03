import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FranchiseApplyScreen extends StatefulWidget{
  static const String routeName = '/FranchiseApplyScreen';

  const FranchiseApplyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FranchiseApplyScreen();
}

class _FranchiseApplyScreen extends State<FranchiseApplyScreen> {
  var currentSelectedValue;
  var currentSelectedLevelValue;
  var currentSelectedLearningValue;
  late int level;

  /*     TextField      */
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
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



  List<String> institutes = [];
  List<String> levels = [];
  List<String> learningModes = [];
  bool isLoading= false;
  // Initially password is obscure
  bool _showPassword = false;
  bool confirmPassword = false;

  bool partnerValue = false;

  late String fullNameVal, emailVal, passwordVal, confirmPasswordVal, phoneVal, stdVal, dobVal, addressVal;


  @override
  void initState() {
    super.initState();
    //getInstituteData();

    institutes.add("Centre A");
    institutes.add("Centre B");
    institutes.add("Centre C");


    levels.add("Level A");
    levels.add("Level B");
    levels.add("Level C");
    levels.add("Level D");


    learningModes.add("One on One Class");
    learningModes.add("Group Class");
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
        title: const Text("Apply for a new centre"),
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
            child: Column(
              children: [

                inputFields(),

                /*    Create Button      */
                Container(
                  margin: const EdgeInsets.only(top: 20,bottom: 20, left: 20, right: 20),
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                     //  32   backgroundColor: const Color(0xFF063464),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: const BorderSide(color: Color(0xFF063464))),
                          elevation: 6.0
                      ),
                      onPressed: () {


                      },
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                            fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white),
                      )
                  ),
                ),

              ],
            )),
      ),
    ),
      ],
    );
  }

  inputFields() {
    return Form(
        key: _formKey,
        child: Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  /*     Name      */
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

                  /*     Email      */
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

                  /*     Contact Number    */
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
                              return "Please enter contact number";
                            } else if (val.length != 10) {
                              return "Contact Number must be of 10 digit";
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
                              hintText: "Contact Number",
                              hintStyle: const TextStyle(
                                  color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat")),
                        ),
                      ),
                    ),
                  ),

                  /*     STD      */
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
                            focusNode: stdFocus,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            controller:stdController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Please enter std";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val)=> stdVal =val!,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(dobFocus);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'images/std_icon.png',
                                    width: 10,
                                    height: 10,
                                    color: const Color(0xFF0F6027),
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: "STD",
                                hintStyle: const TextStyle(
                                    color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat")),
                          ),
                        ),
                      )),

                  /*     Date of Birth      */
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
                            focusNode: dobFocus,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            controller:dobController,
                            keyboardType: TextInputType.datetime,
                            textInputAction: TextInputAction.next,
                            validator: (val){
                              if (val!.isEmpty) {
                                return "Please enter dob";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val)=> dobVal  =val!,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(addressFocus);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'images/dob_icon.png',
                                    width: 10,
                                    height: 10,
                                    color: const Color(0xFF0F6027),
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: "Date of Birth",
                                hintStyle: const TextStyle(
                                    color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat")),
                          ),
                        ),
                      )),

                  /*     Address      */
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

                  /*     Select Mode      */
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

                  /*     Centre Name      */
                  Container(
                    height: 50,
                    alignment : Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),

                        child: dropDown()
                    ),
                  ),

                  /*     Password    */
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

                  /*     Confirm Password    */
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
                          focusNode: confirmPwdFocus,
                          controller: _confirmPass,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val){
                            if (val!.isEmpty) {
                              return "Please enter confirm password";
                            } else if (val!= _pass.text) {
                              return "Not Match";
                            } else {
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

      );
  }

  /*      Select Live Mode Functions   */
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
                            currentSelectedLearningValue = newValue;
                          });
                        },
                        items: learningModes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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

  /*    Center Drop Down Functions   */
  dropDown() {
    return Stack(
      children: <Widget>[

        dropDownInstImg(),
        dropDownInst()

      ],

    );
  }

  dropDownInst() {
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
                        hint: const Text("Please select Centre name"),
                        dropdownColor: Colors.white,
                        value: currentSelectedValue,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedValue = newValue;
                            //level = int.parse(newValue["inst_id"]);
                          });
                        },
                        items: institutes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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

  dropDownInstImg() {
    return Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'images/institute_icon.png',
                    width: 20,
                    height: 20,
                    color: const Color(0xFF0F6027),
                    // fit: BoxFit.fill,
                  ),
                ),

            ),
          ),

        ],

    );
  }

  /*    Level Drop Down Functions   */
  levelDropDown() {
    return Stack(
      children: <Widget>[

        levelDropDownInstImg(),
        levelDropDownInst()

      ],

    );
  }

  levelDropDownInst() {
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
                        hint: const Text("Please select your level."),
                        dropdownColor: Colors.white,
                        value: currentSelectedLevelValue,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedLevelValue = newValue;
                            //level = int.parse(newValue["inst_id"]);
                          });
                        },
                        items: levels.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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

  levelDropDownInstImg() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'images/institute_icon.png',
                width: 20,
                height: 20,
                color: const Color(0xFF0F6027),
                // fit: BoxFit.fill,
              ),
            ),

          ),
        ),

      ],

    );
  }

}

