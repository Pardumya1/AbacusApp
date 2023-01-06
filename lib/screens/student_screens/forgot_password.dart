import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/ForgotPassword';

  const ForgotPassword({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController emailController = new TextEditingController();
  // Initially password is obscure

  late String _email;
  bool isLoading= false;

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
            title: const Text('Forgot Password'),
            leading: IconButton(
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
                // Navigator.pop(context, true);
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
            titleTextStyle: TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Color(0xFF47473F), fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            decoration: const BoxDecoration(image: DecorationImage(
              image: AssetImage("images/forgot_pass.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
            ),
            child: SafeArea(
                child: Column(
                  children: [
                    const Text("Enter your registered email to verify \n your account",
                      textAlign: TextAlign.center,
                      style: TextStyle(decoration: TextDecoration.none, fontSize: 14.0, color: Color(0xFF47473F), fontFamily: "Montserrat", fontWeight: FontWeight.w500),),

                    inputFields() ,

                  ],

                )
            ),
          ),
        ),
      ],
    );

  }

  inputFields() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());

    return Form(
        key: _formKey,
        child: Expanded
          (
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                 // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

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
                              controller:emailController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val){
                                if (val!.isEmpty) {
                                  return "Please enter email";
                                } else if (!regex.hasMatch(val)) {
                                  return "Please enter valid email";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val)=>_email=val!,
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

                    Container(
                      margin: const EdgeInsets.only(top: 50,bottom: 10),
                      width: 320.0,
                      height: 50.0,
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            primary : const Color(0xFF063464),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                side: const BorderSide(color: Color(0xFF063464))),
                            elevation: 6.0
                        ),

                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.w500),
                        ),

                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            // Internet_check().check().then((intenet) {
                            //   if (intenet != null && intenet) {
                            //     submit(emailController.text);
                            //     //register(emailController.text,_pass.text,_confirmPass.text,phoneController.text,nameController.text,);
                            //   }else{
                            //     Fluttertoast.showToast(
                            //       msg: "No Internet Connection",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.BOTTOM,
                            //       timeInSecForIosWeb: 1,
                            //     );
                            //   }
                            //   // No-Internet Case
                            // }
                            // );
                            //submit(emailController.text);

                          }
                        },
                      ),
                    )

                  ],
                )))
    );
  }

}

