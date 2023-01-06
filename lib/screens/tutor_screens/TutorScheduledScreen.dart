import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TutorScheduledClass extends StatefulWidget {
  static const String routeName = '/TutorScheduledClass';

  const TutorScheduledClass({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TutorScheduledClass();
}

class _TutorScheduledClass extends State<TutorScheduledClass>
    with SingleTickerProviderStateMixin {
  int weekDay = 0;

  @override
  void initState() {
    var d = DateTime.now();
    // var weekDay = d.weekday;
    weekDay = d.weekday;
    var firstDayOfWeek = d.subtract(Duration(days: weekDay));

    print("weekDay$weekDay");
    print("firstDayOfWeek$firstDayOfWeek");

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
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, bottom: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Scheduled classes",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat",
                          color: Colors.black),
                    ),
                  ),
                  Flexible(
                      child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                        child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              weekDay == 1
                                  ? Container(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20, left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFFF0F3FF),
                                      ),
                                      child: const Text('Mon'),
                                    )
                                  : const Text('Mon'),

                              weekDay == 2
                                  ?
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF0F3FF),
                                ),
                                child: const Text('Tue'),
                              ) : const Text('Tue'),

                              weekDay == 3
                                  ?
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF0F3FF),
                                ),
                                child: const Text('Wed'),
                              ):const Text('Wed'),

                              weekDay == 4
                                  ?
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF0F3FF),
                                ),
                                child: const Text('Thu'),
                              ):const Text('Thu'),

                              weekDay == 5
                                  ?
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF0F3FF),
                                ),
                                child: const Text('Fri'),
                              ):const Text('Fri'),

                              weekDay == 6
                                  ?
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF0F3FF),
                                ),
                                child: const Text('Sat'),
                              ):const Text('Sat'),

                              weekDay == 7
                                  ?
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 20, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF0F3FF),
                                ),
                                child: const Text('Sun'),
                              ):const Text('Sun'),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 40, left: 20),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  "Timing",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Montserrat",
                                      color: Colors.black),
                                ),
                              ),
                              Expanded(
                                  flex: 8,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text(
                                      "Classes",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Montserrat",
                                          color: Colors.black),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, position) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    top: 20.0, left: 20.0, right: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFFFFFFF),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                            margin: const EdgeInsets.only(top: 20),
                                            child: Column(children: const <Widget>[
                                              Text(
                                                "10:30am",
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Montserrat",
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "11:30am",
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Montserrat",
                                                    color: Colors.grey),
                                              ),
                                            ]))),
                                    Expanded(
                                        flex: 8,
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: const Color(0xFFF0F3FF),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                      margin: const EdgeInsets.only(
                                                          top: 10, right: 10),
                                                      height: 45,
                                                      width: 45,
                                                      padding:
                                                          const EdgeInsets.all(14),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Color(0xFF063464),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        "images/editpen_icon.png",
                                                        width: 60,
                                                        height: 50,
                                                      )),
                                                  Flexible(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets.only(
                                                                  top: 10,
                                                                  right: 20),
                                                          child: const Text(
                                                            "Title",
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontFamily:
                                                                    "Montserrat",
                                                                color:
                                                                    Colors.black),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets.only(
                                                                  right: 20),
                                                          child: const Text(
                                                            "Level",
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Montserrat",
                                                                color:
                                                                    Colors.black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 20, top: 10),
                                                alignment: Alignment.centerLeft,
                                                child: const Text(
                                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the "
                                                    "1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing "
                                                    "and typesetting industry.",
                                                    maxLines: 4,
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
                                                margin: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Color(0xFF063464),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(10),
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      right: 10),
                                                              child: Text(
                                                                  "Take Class",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none,
                                                                      fontSize:
                                                                          14.0,
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          "Montserrat",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                            ),
                                                            Image.asset(
                                                              'images/right_arrow.png',
                                                              width: 14,
                                                              height: 14,
                                                              color: Colors.white,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ]),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.only(
                                                          left: 10),
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right: 5),
                                                              child: Image.asset(
                                                                'images/clock_icon.png',
                                                                width: 16,
                                                                height: 16,
                                                                color: const Color(
                                                                    0xFF063464),
                                                                fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      right: 10),
                                                              child: Text("40 Min",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none,
                                                                      fontSize:
                                                                          14.0,
                                                                      color: Color(
                                                                          0xFF063464),
                                                                      fontFamily:
                                                                          "Montserrat",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                            )
                                                          ]),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ))
                ],
          )),
        ),
      ],
    );
  }
}
