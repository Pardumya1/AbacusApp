
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/constants.dart';


class PDFScreen extends StatefulWidget {

  static const String routeName = '/PDFScreen';
  final String UploadPDF;
  const PDFScreen({required this.UploadPDF ,Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PDFScreen();

}

class _PDFScreen extends State<PDFScreen>
    with WidgetsBindingObserver {

  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late File _file;

  final emailFocus = FocusNode();
  final TextEditingController newEmailController = TextEditingController();

  String emailVal = "";


  Future getFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf']
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });

      _uploadFile(context);

      debugPrint("file : $_file");

    } else {
      // User canceled the picker
    }
  }


  void _uploadFile(Context context) async {
    String fileName = basename(_file.path);
    print("file base name:$fileName");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      FormData formData = FormData.fromMap({
        "student_id": "1",
        "student_type": "0",
        "level_code": "212313",
        "pdf_file": await MultipartFile.fromFile(_file.path, filename: fileName),
      });


      Response response = await Dio().post("https://abacus.mytura.in/api/student_app_submit",
          data: formData,
          options: Options(
              headers: {
                'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
              },
              validateStatus: (_) => true
          )
      );
      print("File upload response: $response");

      Map<String, dynamic> dataObj = json.decode(response.toString());
      debugPrint("dataObj : $dataObj");

      if(dataObj['status'] == "true"){

        Fluttertoast.showToast(
          msg: dataObj['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );

        Navigator.pop(this.context);
      }

   /*   Fluttertoast.showToast(
        msg: dataObj['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );*/

      // _showSnackBarMsg(response.data['message']);
    } catch (e) {
      print("expectation Caugch: $e");
    }

  }


  @override
  void initState() {

    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light
        )
    );


    return Scaffold(

        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Column(children: <Widget>[

          /*     Toolbar View      */
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Image.asset(
                          "images/logo_white.png",
                          width: 60,
                          height: 60,
                        )),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: const EdgeInsets.only(right: 5, top: 10),
                          child: const Image(
                            image: AssetImage("images/menu_logout.png"),
                            height: 24,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                top: 15, bottom: 5, right: 10),
                            child: const Text(
                              "Exit",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                  color: Colors.white),
                            )),
                      ]),
                )
              ],
            ),
          ),

          // Flexible(
          //   flex: 1,
          //   child: SfPdfViewer.network(
          //     widget.UploadPDF,
          //     key: _pdfViewerKey,
          //   ),
          // ),

          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: const Color(0xFF063464),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Color(0xFF063464))),
                        elevation: 6.0
                    ),
                    onPressed: (){

                      getFile();

                      // final isValid = _formKey.currentState!.validate();
                      // if (!isValid) {
                      //   return;
                      // }
                      // _formKey.currentState!.save();



                      // loginFunction(newEmailController.text, newPasswordController.text);

                    },
                    child: const Text("Upload Answer PDF", style: TextStyle(fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500))
                ),
              ],
            ),
          ),

        ]));
  }

}

