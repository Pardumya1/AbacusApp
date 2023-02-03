import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../style/theme.dart';
import '../utils/jitsi_meet_utils.dart';

class HostMeetingCard extends StatefulWidget {

  const HostMeetingCard({super.key});

  @override
  _HostMettingCardState createState() => _HostMettingCardState();
}

class _HostMettingCardState extends State<HostMeetingCard> {

  TextEditingController meetingTitleController = new TextEditingController();

  var _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'; //all characters
  Random _rnd = Random();
  String? randomMeetingCode; //meeting room
  bool isLoading = false;
  String? joinWebUrl;
  String? linkMessage;

  @override
  void initState() {
    randomMeetingCode = getRandomString(9);
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: JitsiMeetUtils().onConferenceWillJoin,
        onConferenceJoined: JitsiMeetUtils().onConferenceJoined,
        onConferenceTerminated: JitsiMeetUtils().onConferenceTerminated,
        onError: JitsiMeetUtils().onError));

    super.initState();
  }


  //Regerating Random Meeting Code
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {

    joinWebUrl = "$randomMeetingCode";
    double screnWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        joinMeetingCard(screnWidth)
      ],
    );
  }

  Widget joinMeetingCard(double screnWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: CustomTheme.boxShadow,
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 40, bottom: 50, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "createAMeeting",
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    height: 48.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      border: Border.all(color: CustomTheme.lightColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  randomMeetingCode!,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                              child: const Icon(
                                Icons.content_copy,
                                color: CustomTheme.primaryColor,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  /* user meeting title textField */

                  TextFormField(
                    autofocus: false,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(fontFamily: "Montserrat"),
                    controller:meetingTitleController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,

                    decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.0),
                        ),
                        border: InputBorder.none,
                        hintText: "Name",
                        hintStyle: TextStyle(
                            color: Color(0xFFBFC1BF), fontSize: 14, fontFamily: "Montserrat")),
                  ),

                  const SizedBox(height: 15.0),
                  const SizedBox(height: 15.0),
                  GestureDetector(
                      onTap: () async {
                        debugPrint("Click Check");
                        hostMeetingFunction();
                      },
                      child: const Text( 'Hello World', ) )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  hostMeetingFunction() async {
    setState(() {
      isLoading = true;
    });
    String meetingTitle = meetingTitleController.value.text;
    //0 is default user id when app is free mode
    setState(() {
      isLoading = false;
    });
    JitsiMeetUtils().hostMeeting(
        roomCode: "randoQ44mMeeting2Code", meetingTitle: "meetingTitle");

  }
}
