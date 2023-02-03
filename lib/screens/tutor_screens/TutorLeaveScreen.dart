import 'dart:convert';
import 'package:abacus_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorLeave extends StatefulWidget {
  static const String routeName = '/TutorLeave';
  @override
  State<StatefulWidget> createState() => _TutorLeave();
}

class _TutorLeave extends State<TutorLeave> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();


  String leaveTitle = "";
  String leaveType = "";
  String leaveStartDate = "";
  String leaveEndDate = "";

  var leaveTypeList = [
    'Casual Leave',
    'Sick Leave',
  ];

  var leaveTypeValue;


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
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark
            ),
            title: const Text("Leave Apply"),
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
                  color: Colors.black,
                  // fit: BoxFit.fill,
                ),
              ),
            ),

            titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: "Montserrat"),
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
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(0),
          child: Column(
              children: [

                /*    Fields       */
                inputFields(),

                /*    Create Button      */
                Container(
                  margin: const EdgeInsets.only(top: 20,bottom: 10, left: 20, right: 20),
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


                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white),
                      )

                  ),
                ),


              ])
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

                  /*      Leave Title     */
                  Container(
                    alignment : Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    child: const Text("Leave Title", style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        color: Colors.black)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                      child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                          child: TextFormField(
                            autofocus: true,
                            readOnly: false,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            controller: titleController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    color: Color(0xFF424943), fontSize: 14, fontFamily: "Montserrat")),
                          ),
                        ),
                      )),

                  /*      Leave Type     */
                  Container(
                    alignment : Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    child: const Text("Leave Type", style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        color: Colors.black)),
                  ),
                  Container(
                    height: 50,
                    alignment : Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),
                        child: dropDownLeaveType()
                    ),
                  ),

                  /*      Leave Start Date     */
                  Container(
                    alignment : Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    child: const Text("Leave Start Date", style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        color: Colors.black)),
                  ),
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
                          controller: startDateController, //editing controller of this TextField
                          decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today, color: Color(0xFF0F6027), ), //icon of text field
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
                                        backgroundColor: Colors.black, // button text color
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
                                startDateController.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          },
                        ),

                      ),
                    ),
                  ),

                  /*      Leave End Date     */
                  Container(
                    alignment : Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    child: const Text("Leave End Date", style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        color: Colors.black)),
                  ),
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
                          controller: endDateController, //editing controller of this TextField
                          decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today, color: Color(0xFF0F6027), ), //icon of text field
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
                                        backgroundColor: Colors.black, // button text color
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
                                endDateController.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          },
                        ),

                      ),
                    ),
                  ),

                  /*      Leave Description     */
                  Container(
                    alignment : Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    child: const Text("Leave Description", style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        color: Colors.black)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                      child: Material(
                        elevation: 1.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                          child: TextFormField(
                            autofocus: true,
                            readOnly: false,

                            maxLines: 4,
                            textAlignVertical: TextAlignVertical.center,
                            style: const TextStyle(fontFamily: "Montserrat"),
                            controller: descriptionController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                    color: Color(0xFF424943), fontSize: 14, fontFamily: "Montserrat")),
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


  /*      Leave Type Drop Down Functions   */
  dropDownLeaveType() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child:  Padding(
              padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 5.0),
              child: FormField<dynamic>(
                builder: (FormFieldState<dynamic> state) {
                  return InputDecorator(
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: leaveTypeValue,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            leaveTypeValue = newValue;
                          });
                        },
                        items: leaveTypeList.map((String value) {
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



}

