
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import 'model/getStudentRegisterDataModel.dart';

class EditAccount extends StatefulWidget {

  static const String routeName = '/EditAccount';

  final String fullName;
  final String email;
  final String phone;
  final String std;
  final String gender;
  final String mode;
  final String dob;
  final String address;

  final List<ModeModel> learningModesList;
  final List<StandardModel> standardList;

  const EditAccount({super.key, required this.fullName, required this.email, required this.address, required this.gender, required this.mode, required this.dob, required this.std, required this.phone, required this.learningModesList, required this.standardList});

  @override
  State<StatefulWidget> createState() => _EditAccount();
}

class _EditAccount extends State<EditAccount> {

  var currentSelectedLearningValue;
  var currentSelectedStandardValue;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final nameFocus = FocusNode();
  final DOBFocus = FocusNode();
  final addressFocus = FocusNode();

  late String fullName, email, phone, gender, dateOfBirth, address;

  @override
  void initState() {
    super.initState();

    currentSelectedLearningValue = widget.mode;
    currentSelectedStandardValue = widget.std;

    fullName = widget.fullName;
    nameController.text = widget.fullName;

    email = widget.email;
    emailController.text = widget.email;

    phone = widget.phone;
    phoneController.text = widget.phone;

    dateOfBirth = widget.dob;
    dobController.text = widget.dob;

    address = widget.address;
    addressController.text = widget.address;

    gender = widget.gender;

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
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark),
            title: const Text("Edit"),
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
                  // fit: BoxFit.fill,
                ),
              ),
            ),
            titleTextStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF47473F),
                fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.fill)),
            child: SafeArea(
                child: Column(
                  children: [

                    const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text("Edit account details",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14.0,
                                color: Color(0xFF47473F),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w500))),

                    inputFields(),

                    /*     Submit Button    */
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right:30),
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            //  32  backgroundColor: const Color(0xFF063464),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  side: const BorderSide(color: Color(0xFF063464))),
                              elevation: 6.0),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 18.0,
                                color: Colors.white),
                          ),
                          onPressed: () {

                            final isValid = _formKey.currentState!.validate();
                            if (!isValid) {
                              return;
                            }
                            _formKey.currentState!.save();

                            debugPrint('Name : $fullName'
                                '\nEmail : $email'
                                '\nStandard : $currentSelectedStandardValue'
                                '\nDate Of Birth : $dateOfBirth'
                                '\nAddress : $address'
                                '\nGender : $gender'
                                '\nContact Number : $phone'
                                '\nCurrent Selected Learning Value : $currentSelectedLearningValue');

                            showLoaderDialog(context);
                            editProfileFunction();

                          }),
                    ),
                  ],
                ),
            ),
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
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                /*     Name        */
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
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter name";
                            } else if (val.length < 3) {
                              return "Name must be more than 2 charater";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => fullName = val!,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(emailFocus);
                          },
                          decoration: InputDecoration(
                              labelText: widget.fullName,
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
                              hintText: "Name",
                              hintStyle: const TextStyle(
                                  color: Color(0xFFBFC1BF),
                                  fontSize: 14,
                                  fontFamily: "Montserrat")),
                        ),
                      ),
                    )),

                /*     Email     */
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter email";
                          }
                          else {
                            return null;
                          }
                        },
                        onSaved: (val) => email = val!,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(phoneFocus);
                        },
                        decoration: InputDecoration(
                            labelText: widget.email,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'images/email_icon.png',
                                width: 10,
                                height: 10,
                                color: Color(0xFF657269),
                                // fit: BoxFit.fill,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: const TextStyle(
                                color: Color(0xFFBFC1BF),
                                fontSize: 14,
                                fontFamily: "Montserrat")),
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
                      side: const BorderSide(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                      child: TextFormField(
                        autofocus: false,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(fontFamily: "Montserrat"),
                        focusNode: phoneFocus,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter contact number";
                          }
                          else if (val.length != 10) {
                            return "Contact Number must be of 10 digit";
                          }
                          else {
                            return null;
                          }
                        },
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).requestFocus(DOBFocus);
                        },
                        onSaved: (val) => phone = val!,
                        decoration: InputDecoration(
                            labelText: widget.phone,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'images/call_icon.png',
                                width: 10,
                                height: 10,
                                color: Color(0xFF657269),
                                // fit: BoxFit.fill,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: "Contact Number",
                            hintStyle: const TextStyle(
                                color: Color(0xFFBFC1BF),
                                fontSize: 14,
                                fontFamily: "Montserrat")),
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

                /*     Date Of Birth       */
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

                          debugPrint("DateTime : "+DateTime.now().toString());

                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1000),
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
                                      //  32 foregroundColor: Colors.black, // button text color
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
                              dobController.text = formattedDate;
                              dateOfBirth = formattedDate;
                            });
                          }else{
                            print("Date is not selected");
                          }
                        },
                      ),

                    ),
                  ),
                ),

                /*     Address      */
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Material(
                    elevation: 1.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(color: Colors.white)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 0.0, right: 5.0),
                      child: TextFormField(
                        autofocus: false,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontFamily: "Montserrat"),
                        focusNode: addressFocus,
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter address";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) => address = val!,
                        decoration: InputDecoration(
                            labelText: widget.address,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'images/address_icon.png',
                                width: 10,
                                height: 10,
                                color: Color(0xFF657269),
                                // fit: BoxFit.fill,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: "Address",
                            hintStyle: const TextStyle(
                                color: Color(0xFFBFC1BF),
                                fontSize: 14,
                                fontFamily: "Montserrat")),
                      ),
                    ),
                  ),
                ),

                /*     Learning Mode     */
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: const BorderSide(color: Colors.white)),
                      child: dropDownLearning()),
                ),


              ],
            ),
          ),
        ),
      ),
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

                        items: widget.standardList.map((map) =>
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


  /*     Learning mode      */
  dropDownLearning() {
    return Stack(
      children: <Widget>[dropDownLearningImg(), dropDownMode()],
    );
  }

  dropDownMode() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 48.0, right: 5.0),
              child: FormField<dynamic>(
                builder: (FormFieldState<dynamic> state) {
                  return InputDecorator(
                    decoration: InputDecoration.collapsed(hintText: ''),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("Select Mode"),
                        dropdownColor: Colors.white,
                        value: currentSelectedLearningValue,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedLearningValue = newValue;
                          });
                        },

                        items: widget.learningModesList.map((map) =>
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
                color: Color(0xFF657269),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }


  /*    Edit Profile Function        */
  void editProfileFunction() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try{
      Response response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.editProfileEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
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
            'id': prefs.getString(ApiConstants.studentID).toString(),
            'student_type' : prefs.getString(ApiConstants.studentLoginType).toString(),
            'student_image' : "image.jpg",

          }
      );

      Navigator.pop(context);
      Map<String, dynamic> dataObj = json.decode(response.body);
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
        addStringToSF(ApiConstants.studentPhoneNumber, data["phone_number"].toString());
        addStringToSF(ApiConstants.studentDeviceToken, data["device_token"].toString());
        addStringToSF(ApiConstants.studentDeviceType, data["device_type"].toString());

        debugPrint("Mode : "+data["mode"].toString());


        Fluttertoast.showToast(
          msg: dataObj['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pop(context);

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


  /*      Shared Preferences     */
  addStringToSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }


}
