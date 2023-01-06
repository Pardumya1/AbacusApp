import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tutor_screens/tutor_login_screen.dart';

class SignupMargeScreen extends StatefulWidget{
  static const String routeName = '/SignupMargeScreen';

  const SignupMargeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupMargeScreenState();


}

class _SignupMargeScreenState extends State<SignupMargeScreen> {

  /*   TextField   */
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final addressFocus = FocusNode();
  final pwdFocus = FocusNode();
  final confirmPwdFocus = FocusNode();


  /*    DropDown   */
  var currentSelectedValue;
  List<String> centres = [];


  bool isLoading= false;

  /*    Initially password is obscure   */
  bool showPasswordBool = false;
  bool confirmPasswordBool = false;


  /*   Variables    */
  late String fullNameVal, emailVal, passwordVal, confirmPasswordVal, phoneVal, addressVal;


  @override
  void initState() {
    super.initState();

    /*    DropDown Values    */
    centres.add("Centre A");
    centres.add("Centre B");
    centres.add("Centre C");

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
                child: Column(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text("Create an Account",
                            textAlign: TextAlign.center,
                            style: TextStyle(decoration: TextDecoration.none, fontSize: 14.0, color: Color(0xFF47473F), fontFamily: "Montserrat", fontWeight: FontWeight.w500)
                        )),

                    inputFields()

                  ],
                )),
          ),

        ),

      ],

    );
  }


  /*     All Fields Function      */
  inputFields() {
    return
      Form(
        key: _formKey,
        child: Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 30, right:30, top: 40),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  /*    name    */
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
                            onSaved: (val)=>fullNameVal=val!,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(addressFocus);
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

                  /*    email    */
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
                          onSaved: (val)=>emailVal =val!,
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

                  /*    contact number   */
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
                          onSaved: (val)=>phoneVal=val!,
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

                  /*     address   */
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
                          onSaved: (val)=>addressVal =val!,
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

                  /*     password     */
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
                          controller: passController,
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
                          onSaved: (val)=>passwordVal=val!,
                          onFieldSubmitted: (v){
                            FocusScope.of(context).requestFocus(confirmPwdFocus);
                          },
                          obscureText: !showPasswordBool,
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
                                icon: Icon(showPasswordBool ? Icons.visibility_outlined : Icons
                                    .visibility_off_outlined, color: const Color(0xFF424943)),
                                onPressed: () {
                                  setState(() => showPasswordBool = !showPasswordBool);
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

                  /*     confirm password   */
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
                          controller: confirmPassController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val){
                            if (val!.isEmpty) {
                              return "Please enter confirm password";
                            } else if (val!= passController.text) {
                              return "Not Match";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val)=>confirmPasswordVal=val!,
                          obscureText: !confirmPasswordBool,
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
                                icon: Icon(showPasswordBool ? Icons.visibility_outlined : Icons
                                    .visibility_off_outlined, color: const Color(0xFF424943)),
                                onPressed: () {
                                  setState(() => confirmPasswordBool = !confirmPasswordBool);
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


                  /*    Create Button      */
                  Container(
                    margin: const EdgeInsets.only(top: 50,bottom: 10),
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF063464),
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

                  // createAccount()

                ],
              ),
            ),
          ),
        ),
      );
  }


  /*     Bottom Line Function    */
  createAccount() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: const Color(0xFF999999),
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
              MaterialPageRoute(builder: (BuildContext context) => const TutorLoginScreen(loginType: 'textDemo', loginTypeName:"name")));
        },
      ),
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
                            currentSelectedValue = newValue!;
                            //level = int.parse(newValue["inst_id"]);
                          });
                        },
                        items: centres.map((String value) {
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

}

