import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/constants.dart';
import '../../studentHome.dart';


class QuizzScreen extends StatefulWidget {
  final String name;
  final String id;
  final String level;
  final List questionList;

  const QuizzScreen({required this.name, required this.id, required this.questionList, required this.level, Key? key}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  final answerFocus = FocusNode();
  final TextEditingController answerController = TextEditingController();
  List<AnswerModel> answerList = [];

  var detailsArray = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
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

    Future<bool> showExitPopup() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Test'),
          content: const Text('Do you want to end this test?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Yes'),
            ),
          ],
        ),
      ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
        onWillPop: showExitPopup,
        child: Stack(children: <Widget>[
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
                      statusBarBrightness: Brightness.dark),
                  title: Text(widget.name),
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
                        color: Colors.white,
                        // fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  titleTextStyle: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: "Montserrat"),
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: buildBody()
            )
        ]
        )
    );

  }

  Widget buildBody() {
    return SizedBox(
        width: double.infinity,
        child: Stack(children: [
          const Image(image: AssetImage("images/home_bg.png"), fit: BoxFit.fill),

          showContent(),

        ]
        )


    );
  }

  /*  Show Content   */
  showContent() {
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                child: PageView.builder(
                  controller: _controller!,
                  onPageChanged: (page) {
                    if (page == widget.questionList.length - 1) {
                      setState(() {
                        btnText = "Submit";
                      });
                    }
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 7,
                                  child: Text("Question ${index + 1}/${widget.questionList.length}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w600))),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      child: Text("${widget.questionList[index]['Marks']} marks",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 16.0,
                                              color: Colors.white,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600))
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 5, right: 5, top :5),
                                  padding: const EdgeInsets.all(20),
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight:
                                          Radius.circular(20.0),
                                          topLeft:
                                          Radius.circular(20.0)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "images/background.png"),
                                          fit: BoxFit.cover)),
                                  child: Text(
                                    widget.questionList[index]['Question'],
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Montserrat",
                                        color: Colors.black),
                                  )
                              ),

                              Container(
                                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                padding: const EdgeInsets.only(top:10, left: 10, right: 10, bottom: 20),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft:
                                        Radius.circular(20.0),
                                        bottomRight:
                                        Radius.circular(20.0)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "images/background.png"),
                                        fit: BoxFit.cover)),
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Form(
                                          key: _formKey,
                                          child: TextFormField(
                                            autofocus: false,
                                            autocorrect: false,
                                            focusNode: answerFocus,
                                            controller: answerController,
                                            keyboardType: TextInputType.multiline,
                                            minLines: 4,
                                            maxLines: 8,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xFFF2F2F2),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                                borderSide: BorderSide(width: 1),
                                              ),
                                            ),
                                          )),

                                    ]),
                              ),

                              RawMaterialButton(
                                onPressed: () {
                                  final isValid = _formKey.currentState!.validate();
                                  if (!isValid) {
                                    return;
                                  }

                                  _formKey.currentState!.save();

                                  Map<String, String> details = {};
                                  details["question_id"] = widget.questionList[index]['id'].toString();
                                  details["answer"] = answerController.text.toString();

                                  detailsArray.add(details);
                                  answerController.text = "";

                                  if (_controller!.page?.toInt() == widget.questionList.length - 1) {

                                    // showLoaderDialog(context);
                                    submitTestFunction(context);

                                  } else {
                                    _controller!.nextPage(
                                        duration: const Duration(milliseconds: 250),
                                        curve: Curves.easeInExpo);
                                    setState(() {
                                      btnPressed = false;
                                    });
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                fillColor: Colors.blue,
                                padding: const EdgeInsets.all(18.0),
                                elevation: 0.0,
                                child: Text(
                                  btnText,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        )

                      ],
                    );
                  },
                  itemCount: widget.questionList.length,
                )),
          ),
        ));
  }


  /*  Submit Test   */
  void submitTestFunction(BuildContext mContext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("test level;===>"+ widget.level);
    try{
      Response response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.submitStudentTestEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
          body: {
            'student_id' : prefs.getString(ApiConstants.studentID),
            'student_type' : prefs.getString(ApiConstants.studentLoginType),
            'test_id' : widget.id,
            'answers' : json.encode(detailsArray),
            'Level':widget.level,
          }
      );

      // Navigator.pop(mContext);
      Map<String, dynamic> dataObj = json.decode(response.body);
      debugPrint("Data Obj : $dataObj");

      if(dataObj['status'] == "true"){

        Navigator.push(
            mContext,
            MaterialPageRoute(
                builder: (mContext) => const StudentHome()));

        Fluttertoast.showToast(
          msg: dataObj['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );

      }
      else {
        Fluttertoast.showToast(
          msg: dataObj['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );

      }

    }catch(e){
      // Navigator.pop(mContext);
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


}

class AnswerModel {
  String questionId;
  String answer;

  AnswerModel(this.questionId ,this.answer);
}

