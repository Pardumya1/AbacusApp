import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:abacus_app/utils/screen.dart';

var camera;

class Add_video extends StatefulWidget {
  Add_video({var cameras}) {
    camera = cameras;
  }

  static const String routeName = '/Add_video';

  @override
  _Add_videoState createState() => _Add_videoState();
}

class _Add_videoState extends State<Add_video> {
  var multipartFile;
  var jsonData = null;
  late String data1;
  bool video_show = false;
  ImagePicker picker = ImagePicker();
  List<dynamic> Response = [];
  late File videodata;
  late String titledata, descriptiondata;
  late String institute_id, user_id, course_id;
  late String thumbnail;
  late String thumnail_image;
  List<dynamic> deviceTypes = [];
  var superheros_length;
  late int level;
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController descriptionController =
      new TextEditingController();
  bool title_data = false;
  bool desc_data = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: new AssetImage("images/background.png"), fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.dark
              ),
              title: const Text("Add Video"),
              leading: BackButton(
                color: Colors.black,
                onPressed: () => Navigator.pop(context, true),
              ),
              titleTextStyle: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: "Montserrat"),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          Container(
              height: SizeConfig.blockSizeVertical * 15,
              margin: EdgeInsets.only(
                top: 40,
                left: SizeConfig.blockSizeHorizontal * 5,
                right: SizeConfig.blockSizeHorizontal * 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    child: InkWell(
                      // onTap: () {
                      //   _recordVideo();
                      // },
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 40,
                        decoration: BoxDecoration(
                          // color: Color(0xFF063464),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0x421BAA20), Color(0xFF0A437D)]),
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //   color: Color(0xFF063464),
                          //   style: BorderStyle.solid,
                          //   width: 2.0,
                          // ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                              ),
                              child: Image.asset(
                                "images/camera_icon.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                "Create a video",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Montserrat-Bold',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    child: InkWell(
                      // onTap: () {
                      //   _pickVideo();
                      // },
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xFFDBDACC),
                            style: BorderStyle.solid,
                            width: 2.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 2,
                              ),
                              child: Image.asset("images/gallery_icon.png",
                                  height: 40, width: 40),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                "Video from \n Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Montserrat-Bold',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          /*  Level */
          Container(
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 5,
                left: SizeConfig.blockSizeHorizontal * 6,
                right: SizeConfig.blockSizeHorizontal * 5),
            alignment: Alignment.centerLeft,
            child: Text("Level",
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    color: Colors.black)),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(
                top: 15,
                left: SizeConfig.blockSizeHorizontal * 5,
                right: SizeConfig.blockSizeHorizontal * 5),
            child: Material(
              elevation: 6.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.white)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 13.0, bottom: 10.0, left: 20.0, right: 20.0),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration.collapsed(
                          hintText: 'Please select a level'),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                          hint: Text(
                            "Please select a level",
                          ),
                          dropdownColor: Colors.white,
                          value: superheros_length,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              superheros_length = newValue;
                              level = int.parse(newValue["id"]);
                              print(level.toString());
                            });
                          },
                          items: deviceTypes.map((dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text(value["title"]),
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
          /*  Title */
          Container(
            margin: EdgeInsets.only(
                top: 30,
                left: SizeConfig.blockSizeHorizontal * 6,
                right: SizeConfig.blockSizeHorizontal * 5),
            alignment: Alignment.centerLeft,
            child: Text("Title",
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    color: Colors.black)),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(
                top: 15,
                left: SizeConfig.blockSizeHorizontal * 5,
                right: SizeConfig.blockSizeHorizontal * 5),
            child: Material(
              elevation: 6.0,
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: titleController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    errorText: title_data ? 'Value Can\'t Be Empty' : null,
                    border: InputBorder.none,
                    hintText: 'Please enter a title',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          /*  Description  */
          Container(
            margin: EdgeInsets.only(
                top: 30,
                left: SizeConfig.blockSizeHorizontal * 6,
                right: SizeConfig.blockSizeHorizontal * 5),
            alignment: Alignment.centerLeft,
            child: Text("Description",
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    color: Colors.black)),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(
                top: 15,
                left: SizeConfig.blockSizeHorizontal * 5,
                right: SizeConfig.blockSizeHorizontal * 5),
            child: Material(
              elevation: 6.0,
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                    width: 2.0,
                  ),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: descriptionController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    errorText: desc_data ? 'Value Can\'t Be Empty' : null,
                    border: InputBorder.none,
                    hintText: 'Please enter a description',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40, bottom: 10,),
            height: 50.0,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(5),
            //   gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [Color(0xFF1058A3), Color(0xFF063464)]),
            // ),
            child: ElevatedButton(
              child: Text("Submit",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                //  32 backgroundColor: Color(0xFF063464),
                // primary: Colors.transparent,

                padding:
                const EdgeInsets.symmetric(horizontal: 50, ),
                elevation: 6.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
