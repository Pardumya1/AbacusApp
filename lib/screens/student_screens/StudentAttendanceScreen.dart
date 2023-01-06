
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentAttendanceScreen extends StatefulWidget {
  static const String routeName = '/StudentAttendanceScreen';

  const StudentAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StudentAttendanceScreen();
}

class _StudentAttendanceScreen extends State<StudentAttendanceScreen> {
  PageController? calendarPageController;

  //last and first day of calendar
  late DateTime firstDay = DateTime.utc(2010, 10, 16);
  late DateTime lastDay = DateTime.utc(2030, 3, 14);

  //current day
  late DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
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

    calendarPageController?.dispose();

    super.dispose();
  }


  Widget _buildAttendanceCounterContainer(
      {required String title,
        required BoxConstraints boxConstraints,
        required String value,
        required Color backgroundColor}) {
    return Container(
      height: boxConstraints.maxWidth * (0.425),
      width: boxConstraints.maxWidth * (0.425),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
              color: backgroundColor.withOpacity(0.25),
              offset: const Offset(5, 5),
              blurRadius: 10,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: boxConstraints.maxWidth * (0.45) * (0.125),
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Center(
                child: Text(
                  value,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )),
          ),

        ],
      ),
    );
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

    return Stack(children: <Widget>[

      Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light),
            title: const Text("Attendance"),
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
                  //fit: BoxFit.fill,
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
          body: buildBody()),
    ]);
  }

  Widget buildBody() {
    return SizedBox(
        width: double.infinity,
        child: Stack(children: [
          const Image(
              image: AssetImage("images/home_bg.png"), fit: BoxFit.fill),
          showContent()
        ]));
  }

  showContent() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [

              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                ),
                child: TableCalendar(

                  calendarFormat: CalendarFormat.month,
                  headerVisible: true,
                  daysOfWeekHeight: 40,

                  onPageChanged: (DateTime dateTime) {
                    // setState(() {
                    //   focusedDay = dateTime;
                    // });
                    //
                    // //fetch attendance by year and month
                    // context.read<AttendanceCubit>().fetchAttendance(
                    //     month: dateTime.month,
                    //     year: dateTime.year,
                    //     useParentApi: context.read<AuthCubit>().isParent(),
                    //     childId: widget.childId);
                  },

                  onCalendarCreated: (contoller) {
                    calendarPageController = contoller;
                  },

                  //holiday date will be in use to make present dates
                  // holidayPredicate: (dateTime) {
                  //   return presentDays.indexWhere((element) =>
                  //   UiUtils.formatDate(dateTime) ==
                  //       UiUtils.formatDate(element.date)) !=
                  //       -1;
                  // },

                  //selected date will be in use to mark absent dates
                  // selectedDayPredicate: (dateTime) {
                  //   return absentDays.indexWhere((element) =>
                  //   formatDate(dateTime) ==
                  //       formatDate(element.date)) !=
                  //       -1;
                  // },

                  availableGestures: AvailableGestures.none,

                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    holidayTextStyle: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor),
                    holidayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.onPrimary),
                    selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.error),
                  ),

                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                      weekdayStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),

                  headerStyle: const HeaderStyle(
                      titleCentered: true, formatButtonVisible: false),

                  firstDay: firstDay,
                  lastDay: lastDay,
                  focusedDay: focusedDay,

                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * (0.075)),
                child: Column(
                  children: [

                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.05),
                    ),
                    LayoutBuilder(builder: (context, boxConstraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAttendanceCounterContainer(
                              boxConstraints: boxConstraints,
                              title: "Total Present",
                              value: "0",
                              backgroundColor: Colors.lightBlue,
                          ),
                          Spacer(),
                          _buildAttendanceCounterContainer(
                              boxConstraints: boxConstraints,
                              title: "Total Absent",
                              value: "0",
                              backgroundColor:
                              Theme.of(context).colorScheme.error),
                        ],
                      );
                    })
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
