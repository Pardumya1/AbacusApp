
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PDFScreen extends StatefulWidget {

  static const String routeName = '/PDFScreen';
  const PDFScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PDFScreen();

}

class _PDFScreen extends State<PDFScreen>
    with WidgetsBindingObserver {

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  final emailFocus = FocusNode();
  final TextEditingController newEmailController = TextEditingController();

  String emailVal = "";


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
                          "images/logo.png",
                          width: 60,
                          height: 60,
                        )),
                    // Container(
                    //     margin: const EdgeInsets.only(bottom: 5, left: 5),
                    //     child: const Text(
                    //       "Dashboard",
                    //       style: TextStyle(
                    //           decoration: TextDecoration.none,
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold,
                    //           fontFamily: "Montserrat",
                    //           color: Colors.black),
                    //     )),
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
                            color: Colors.black,
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
                                  color: Colors.black),
                            )),
                      ]),
                )
              ],
            ),
          ),

          Flexible(
            flex: 1,
            child: SfPdfViewer.network(
              'https://www.africau.edu/images/default/sample.pdf',
              key: _pdfViewerKey,
            ),
          ),


          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF063464),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: const BorderSide(color: Color(0xFF063464))),
                        elevation: 6.0
                    ),
                    onPressed: (){


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
