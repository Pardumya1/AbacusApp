import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TutorCompensationClassScreen extends StatefulWidget {
  static const String routeName = '/TutorCompensationClassScreen';

  const TutorCompensationClassScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TutorCompensationClassScreen();

}

class _TutorCompensationClassScreen extends State<TutorCompensationClassScreen>
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
              child:  Flexible(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Expanded(
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
                                          "Student Info",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                              color: Colors.black),
                                        ),

                                            SizedBox(height: 10),

                                            Text("Student Name",
                                              style: TextStyle(
                                                  decoration: TextDecoration.none,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Montserrat",
                                                  color: Colors.grey),
                                            ),

                                            SizedBox(height: 2),

                                            Text("Standard",
                                              style: TextStyle(
                                                  decoration: TextDecoration.none,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Montserrat",
                                                  color: Colors.grey),
                                            ),

                                          ]
                                      ))),

                              Expanded(
                                flex: 7,
                                child : Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFFF0F3FF),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [

                                          Expanded(
                                              child: Row(
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
                                                        "images/commpensation_class_icon.png",
                                                        width: 60,
                                                        height: 50,
                                                        color: Colors.white,
                                                      )),

                                                  Flexible(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets.only(top: 10, right: 20),
                                                          child: const Text(
                                                            "Title",
                                                            style: TextStyle(
                                                                decoration: TextDecoration.none,
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: "Montserrat",
                                                                color: Colors.black),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                          const EdgeInsets.only(right: 20),
                                                          child: const Text("Level",
                                                            style: TextStyle(
                                                                decoration: TextDecoration.none,
                                                                fontSize: 16,
                                                                fontFamily: "Montserrat",
                                                                color: Colors.black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                          )),

                                          Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[

                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(left: 10, right: 5),
                                                    child: Image.asset('images/clock_icon.png',
                                                      width: 16,
                                                      height: 16,
                                                      color: const Color(0xFF063464),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(right: 10),
                                                    child: Text("40 Min",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(decoration: TextDecoration.none,
                                                            fontSize: 14.0,
                                                            color: Color(0xFF063464),
                                                            fontFamily: "Montserrat",
                                                            fontWeight: FontWeight.w600)),
                                                  )

                                                ]),
                                          ),

                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(right: 20, top: 10),
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the "
                                                "1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing "
                                                "and typesetting industry.",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection:
                                            TextDirection.ltr,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                decoration:
                                                TextDecoration.none,
                                                fontSize: 14.0,
                                                color: Color(0xFF47473F),
                                                fontFamily: "Montserrat",
                                                fontWeight:
                                                FontWeight.w500)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                                        child: Row(
                                          children: [

                                            Container(
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF063464),
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                ),
                                                padding: const EdgeInsets.all(10),
                                                child: const Padding(
                                                  padding: EdgeInsets.only(right: 10, left: 10),
                                                  child: Text(
                                                      "Accept",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          decoration: TextDecoration.none,
                                                          fontSize:14.0,
                                                          color: Colors.white,
                                                          fontFamily: "Montserrat",
                                                          fontWeight: FontWeight.w600)),
                                                )
                                            ),

                                            Container(
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFD9D9D9),
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                ),
                                                padding: const EdgeInsets.all(10),
                                                margin : const EdgeInsets.only(left: 10),
                                                child: const Padding(
                                                  padding: EdgeInsets.only(right: 10, left: 10),
                                                  child: Text(
                                                      "Cancel",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          decoration: TextDecoration.none,
                                                          fontSize:14.0,
                                                          color: Colors.black,
                                                          fontFamily: "Montserrat",
                                                          fontWeight: FontWeight.w600)),
                                                )
                                            ),

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )

                            ]),
                          );
                        },
                      ),
                    )
                  ))
          ),
        ),
      ],
    );
  }
}
