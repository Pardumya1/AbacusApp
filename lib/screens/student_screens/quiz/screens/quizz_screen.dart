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
  final List questionList;
  const QuizzScreen({required this.name, required this.id, required this.questionList, Key? key}) : super(key: key);

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
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Scaffold(
                backgroundColor: Colors.transparent,
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
                        // fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  titleTextStyle: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: "Montserrat"),
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: showContent())));

  }

  /*  Show Content   */
  showContent() {
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Padding(
                padding: const EdgeInsets.all(18.0),
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
                        Text(
                          "Question ${index + 1}/${widget.questionList.length}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "${widget.questionList[index]['Marks']} marks for the question.",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),

                        const Divider(
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),

                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            widget.questionList[index]['Question'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          ),
                        ),

                        // widget.questionList[index]['Image'].isEmpty ? Container() :
                        //
                        // Container(
                        //   margin: const EdgeInsets.only(bottom: 20),
                        //   child: SizedBox(
                        //       width: double.infinity,
                        //       child:Image.network(
                        //         widget.questionList[index]['Image'],
                        //       )),
                        // ),
                        Form(
                            key: _formKey,
                            child: TextFormField(
                              autofocus: true,
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
                        const SizedBox(
                          height: 20.0,
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

