import 'dart:convert';
import 'package:abacus_app/screens/student_screens/model/upcomingTestModel.dart';
import 'package:abacus_app/screens/student_screens/score_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../../utils/screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayScreen extends StatefulWidget {
  static const String routeName = '/PlayScreen';
  final String levelStatus;
  final String levelId;
  final String name;
  final String gameId;
  final String testDuration;
  final List questionsList;

  const PlayScreen({super.key,required this.testDuration, required this.gameId, required this.levelId, required this.name, required this.questionsList, required this.levelStatus});

  @override
  State<StatefulWidget> createState() => _PlayScreen();

}

class _PlayScreen extends State<PlayScreen> {
  int endTime = 0;
  late CountdownTimerController controller;
  WebViewController? _webViewController;
  String valueData = "";
  PageController? _controller;
  String question1 = "";
  List<questionsListModel> gamesList = [];
  String btnText = "Next Question";
  bool btnPressed = false;
  final answerFocus = FocusNode();
  List<AnswerModel> answerList = [];
  var detailsArray = [];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    debugPrint("Duration-------"+widget.testDuration + "0");
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * (60);
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  @override
  Widget build(BuildContext context) {

    return Stack(children: <Widget>[
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
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light),
            title: Text(widget.name),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Image(
                  image: AssetImage("images/back.png"),
                  width: 14,
                  height: 14,
                  color: Colors.white,
                )),
            actions: [
              GestureDetector(
                  onTap: () {
                   /* Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ScoreScreen()));*/

                  },
                  child: Card(
                      color: const Color(0x783f6098),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Container(
                          alignment: Alignment.center,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Image.asset(
                                    'images/clock_icon.png',
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: CountdownTimer(
                                      controller: controller,
                                      endTime: endTime,
                                      onEnd: onEnd,
                                      widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {
                                        if (time == null) {
                                          return Text('Game over', style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Montserrat",
                                            color: Colors.white,
                                          ) ,);
                                        }
                                        return Text(
                                            '${time.hours == null ? "00": time.hours}:${time.min== null ? "00": time.min}:${time.sec == null ? "00": time.sec}',
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "Montserrat",
                                              color: Colors.white,
                                            )
                                        );
                                      },
                                      textStyle: const TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Montserrat",
                                          color: Colors.white,
                                          ),
                                    )
                                )
                              ])
                      )
                  ))
            ],
            titleTextStyle: const TextStyle(
                decoration: TextDecoration.none,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: "Montserrat"),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: buildBody()
      ),
    ]);
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

  showContent() {
    return SafeArea(
      child:  Container(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),

          child: PageView.builder(
            controller: _controller!,
            onPageChanged: (page) {
              if (page == widget.questionsList.length - 1) {
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
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 7,
                            child: Text("Let’s input number to abacus",
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
                                margin: const EdgeInsets.only(right: 10),
                                child: Text("${index + 1}/${widget.questionsList.length}",
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
                      margin: const EdgeInsets.only(top: 40),
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          image: DecorationImage(
                              image: AssetImage("images/background.png"),
                              fit: BoxFit.cover)),

                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF063464),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  Container(
                                    margin: const EdgeInsets.only(left: 5, right: 5, top :5 ),
                                    padding: const EdgeInsets.all(10),
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
                                        widget.questionsList[index]['Question'],
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Montserrat",
                                            color: Colors.black),
                                      )
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                    padding: const EdgeInsets.all(10),
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
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 10, right: 10),
                                            height: 90,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "?",
                                              style: TextStyle(
                                                  decoration: TextDecoration.none,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Montserrat",
                                                  color: Colors.black),
                                            ),
                                          ),

                                        ]),
                                  ),

                                ]),
                          ),

                          Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/background.png"),
                                      fit: BoxFit.cover)),

                              height: SizeConfig.blockSizeVertical*30,
                              // width: SizeConfig.blockSizeHorizontal*180,
                              width: SizeConfig.blockSizeHorizontal*180,
                              margin: const EdgeInsets.only(left: 10,right: 10, top: 0),
                              child: WebView(

                                initialUrl: 'about:blank',
                                javascriptMode: JavascriptMode.unrestricted,
                                onWebViewCreated: (WebViewController webViewController) async {
                                  _webViewController = webViewController;
                                  String fileContent = await rootBundle.loadString('assets/index.html');
                                  _webViewController?.loadUrl(Uri.dataFromString(fileContent, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
                                },
                                zoomEnabled: false,
                                javascriptChannels: <JavascriptChannel>{
                                  JavascriptChannel(
                                    name: 'messageHandler',
                                    onMessageReceived: (JavascriptMessage message) {

                                      setState(() {
                                        valueData = message.message;
                                        debugPrint("setState");
                                      });

                                    },
                                  )
                                },

                              )

                          ),

                        ],
                      )

                  ),
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
                        onPressed: () async {

                          debugPrint("Data:::===> $valueData");


                          Map<String, String> details = {};
                          details["question_id"] = widget.questionsList[index]['id'].toString();
                          details["answer"] = valueData;

                          detailsArray.add(details);

                          if (_controller!.page?.toInt() == widget.questionsList.length - 1) {

                            // showLoaderDialog(context);
                             submitGameAnswer(context);

                          } else {
                            /* if(valueData == "00000000"){
                               Fluttertoast.showToast(
                                 msg: "Please select some value in abacus",
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.CENTER,
                               );
                             }else{

                             }*/
                            _controller!.nextPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInExpo);
                            setState(() {
                              btnPressed = false;
                            });

                          }

                          valueData = "";

                        },
                        child: Text(
                          btnText,
                          style: TextStyle(
                              fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white),
                        )
                    ),
                  ),


                  /* Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "${widget.questionsList[index]['Marks']} marks for the question.",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),*/

                ],
              );
            },
            itemCount: widget.questionsList.length,
          )
      ),


    );
  }



  showHintsAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 0.0,
            ),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 24),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 30),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF504444),
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  /*  Submit Test   */
  void submitGameAnswer(BuildContext mContext) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    debugPrint(json.encode(detailsArray));

    try{
      Response response = await post(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.submitStudentGameEndpoint),
          headers: {
            'Authorization': 'Bearer ${prefs.getString(ApiConstants.accessTokenSP)}',
          },
          body: {
            'student_id' : prefs.getString(ApiConstants.studentID),
            'student_type' : prefs.getString(ApiConstants.studentLoginType),
            'game_id' : widget.gameId,
            'answers' : json.encode(detailsArray),
            'level' : widget.levelId,
          }
      );

      // Navigator.pop(mContext);
      Map<String, dynamic> dataObj = json.decode(response.body);
      debugPrint("Data Obj : $dataObj");

      if(dataObj['status'] == "true"){

        Navigator.push(
            mContext,
            MaterialPageRoute(
                builder: (mContext) =>  ScoreScreen(level:widget.levelId.toString(), total_marks : dataObj['total_marks'].toString(), student_marks : dataObj['student_marks'].toString(), correct_answers : dataObj['correct_answers'].toString(),
                    wrong_answers : dataObj['wrong_answers'].toString(),total_questions : dataObj['total_questions'].toString(), percentage : dataObj['percentage'].toString(), missed_questions: dataObj['missing_answers'].toString(),
                    questionList: dataObj['answer_correct_list'])
            )
        );

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


  onEnd() {
    print('onEnd');
    submitGameAnswer(context);

  }

}


class AnswerModel {
  String questionId;
  String answer;

  AnswerModel(this.questionId ,this.answer);
}
