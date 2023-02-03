import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../style/theme.dart';
import '../utils/jitsi_meet_utils.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({super.key});

  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  final _joinMeetingFormkey = GlobalKey<FormState>();
  final Random _rnd = Random();
  TextEditingController meetingIDController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: JitsiMeetUtils().onConferenceWillJoin,
        onConferenceJoined: JitsiMeetUtils().onConferenceJoined,
        onConferenceTerminated: JitsiMeetUtils().onConferenceTerminated,
        onError: JitsiMeetUtils().onError));

  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        joinMeetingCard(screenWidth)
      ],
    );
  }

  /*Join Meeting Widget*/
  Widget joinMeetingCard(double screnWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: CustomTheme.boxShadow,
              color: Colors.white,
            ),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 40, bottom: 50, right: 20),
                child: Form(
                  key: _joinMeetingFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "joinAMeeting",
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),

                      TextFormField(
                        autofocus: false,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(fontFamily: "Montserrat"),
                        controller: meetingIDController,
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

                      const SizedBox(
                        height: 22,
                      ),

                      TextFormField(
                        autofocus: false,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(fontFamily: "Montserrat"),
                        controller:nickNameController,
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

                      const SizedBox(height: 22),
                      GestureDetector(
                          onTap: () async {
                            if (_joinMeetingFormkey.currentState!.validate()) {
                              joinMeetingFunction();
                            }
                            // interstitialAd.isLoaded && _rnd.nextInt(100).isEven;
                            //    interstitialAd.show();
                          },
                          child: const Text( 'Hello World', )
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }

  joinMeetingFunction() async {

    if (_joinMeetingFormkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      //0 is default user id when app is free mode

      setState(() {
        isLoading = false;
      });

      // _joinMeeting();
      JitsiMeetUtils().joinMeeting(
          roomCode: meetingIDController.value.text,
          nameText: nickNameController.value.text);

    }
  }


  _joinMeeting() async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p

      var options = JitsiMeetingOptions(room: "roomCode")
        ..serverURL = "https://someHost.com"
        ..subject = "Meeting with Gunschu"
        ..userDisplayName = "My Name"
        ..userEmail = "myemail@email.com"
        ..userAvatarURL = "https://someimageurl.com/image.jpg" // or .png
        ..audioOnly = true
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(options);

    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
