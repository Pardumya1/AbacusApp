import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudentCompensationClassScreen extends StatefulWidget {
  static const String routeName = '/StudentCompensationClassScreen';

  const StudentCompensationClassScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StudentCompensationClassScreen();

}

class _StudentCompensationClassScreen extends State<StudentCompensationClassScreen>
    with SingleTickerProviderStateMixin {

  int weekDay = 0;
  var monthVal = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  var weeklyVal = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  var dateVal = DateTime.now();

  @override
  void initState() {

    // var weekDay = d.weekday;
    weekDay = dateVal.weekday;
    var firstDayOfWeek = dateVal.subtract(Duration(days: weekDay));

    print("weekDay$weekDay");
    print("firstDayOfWeek$firstDayOfWeek");
    print("Day"+dateVal.month.toString());

    super.initState();
  }

  @override
  void dispose() {
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark),
            title: const Text("Compensation Classes"),
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
            titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
              child:Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),

                ),
                child: Column (
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [

                            Container(
                              margin: const EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dateVal.day.toString(),
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat",
                                    color: Colors.black),
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    weeklyVal[dateVal.weekday-1],
                                    style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Montserrat",
                                        color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${monthVal[dateVal.month-1]} ${dateVal.year}",
                                    style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Montserrat",
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, right: 20, bottom: 20),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF0F3FF),
                          ),
                          child: const Text(
                            "Select Date",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat",
                                color: Colors.black),
                          ),
                        ),

                      ],
                    ),

                    Flexible(

                      child: Container(
                        margin: const EdgeInsets.only(top:10),
                        child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, position) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  top: 10.0, left: 20.0, right: 20.0, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFFFFFFF),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                            margin: const EdgeInsets.only(top: 5),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: const <Widget>[

                                                  Text(
                                                    "Course Info",
                                                    style: TextStyle(
                                                        decoration: TextDecoration.none,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Montserrat",
                                                        color: Colors.black),
                                                  ),

                                                  SizedBox(height: 10),

                                                  Text("Course Name",
                                                    style: TextStyle(
                                                        decoration: TextDecoration.none,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "Montserrat",
                                                        color: Colors.grey),
                                                  ),

                                                  SizedBox(height: 2),

                                                ]
                                            ))),

                                    Expanded(
                                      flex: 7,
                                      child : Container(
                                        height: 150,
                                        padding: const EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: const Color(0xFFF0F3FF),
                                            image: const DecorationImage(image: AssetImage('images/compensation_video_img.png'),fit: BoxFit.cover)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(top: 10, right: 10),
                                                height: 45,
                                                width: 45,
                                                padding: const EdgeInsets.all(12),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF063464),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Image.asset(
                                                  "images/play_icon.png",
                                                  width: 60,
                                                  height: 50,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                      ),
                                    )

                                  ]),
                            );
                          },
                        ),
                      )

                    )

                  ],
                )
              )
          ),
        ),
      ],
    );
  }
}
