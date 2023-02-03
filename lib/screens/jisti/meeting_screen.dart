import 'package:abacus_app/screens/jisti/style/theme.dart';
import 'package:abacus_app/screens/jisti/widgets/host_meeting_card.dart';
import 'package:abacus_app/screens/jisti/widgets/join_meeting_card.dart';
import 'package:flutter/material.dart';

class MeetingScreen extends StatefulWidget {
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  int _selectedIndex = 0;
  int selectedScreen = 0;
  PageController? _pageController;
  String? appMode;
  String? userRole;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    appMode =  "free";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: generalMoodWidget(),
      ),
    );
  }

  /*Academic Mode Widget*/
  Widget generalMoodWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 60, bottom: 28),
            child: Text(
              "titleMeetingScreen",
            ),
          ),
          /*Join meeting and Host Meeting Switch Button*/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              tabButton(
                0,
                "joinMeeting",
              ),
              tabButton(
                1,
                "hostMeeting",
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: 430.0,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                /* Join Meeting and Host Meeting Widget*/
                JoinMeeting(),
                HostMeetingCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*navigate between join meeting and host meeting*/
  Widget tabButton(int btnIndex, String btnTitle) {
    return GestureDetector(
      onTap: () {
        _selectedIndex = btnIndex;
        _pageController!.animateToPage(_selectedIndex,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
        setState(() {});
      },
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2.3,
        decoration: BoxDecoration(
          borderRadius: btnIndex == 0
              ? BorderRadius.only(
                  topLeft: Radius.circular(6), bottomLeft: Radius.circular(5))
              : BorderRadius.only(
                  bottomRight: Radius.circular(6),
                  topRight: Radius.circular(5)),
          boxShadow:
              _selectedIndex == btnIndex ? CustomTheme.iconBoxShadow : null,
          color: _selectedIndex == btnIndex ? Colors.white : Color(0xffF0F1F6),
        ),
        child: Center(
          child: Text(
            btnTitle,
            style: TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: _selectedIndex == btnIndex
                    ? Color(0xff222222)
                    : Color(0xff5B5D80)),
          ),
        ),
      ),
    );
  }
}
