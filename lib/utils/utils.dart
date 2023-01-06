import 'package:flutter/material.dart';
import 'package:abacus_app/utils/screen.dart';

double bottomNavigationHeightPercentage = 0.08;
double bottomNavigationBottomMargin = 25;
double extraScreenContentTopPaddingForScrolling = 0.0275;
double appBarMediumtHeightPercentage = 0.2;
double shimmerLoadingContainerDefaultHeight = 7;
double screenContentTopPadding = 15.0;
double appBarBiggerHeightPercentage = 0.25;
double screenTitleFontSize = 18.0;
int defaultShimmerLoadingContentCount = 6;
double screenSubTitleFontSize = 14.0;
double screenContentHorizontalPadding = 25.0;


ColorScheme getColorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

String getMonthName(int monthNumber) {
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[monthNumber - 1];
}


String getImagePath(String imageName) {
  return "assets/images/$imageName";
}



String formatTime(String time) {
  final hourMinuteSecond = time.split(":");
  final hour = int.parse(hourMinuteSecond.first) < 13
      ? int.parse(hourMinuteSecond.first)
      : int.parse(hourMinuteSecond.first) - 12;
  final amOrPm = int.parse(hourMinuteSecond.first) > 12 ? "PM" : "AM";
  return "${hour.toString().padLeft(2, '0')}:${hourMinuteSecond[1]} $amOrPm";
}

launchScreen(context, String tag, {Object? arguments}) {
  if (arguments == null) {
    Navigator.pushNamed(context, tag);
  } else {
    Navigator.pushNamed(context, tag, arguments: arguments);
  }
}

callNext(var className, var context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
}

createUpperBar(context, image) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(
            top: 10, left: SizeConfig.blockSizeHorizontal * 2.3),
        child: Material(
            child: InkWell(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: ClipRRect(
            child: Image.asset(
              'images/back_color.png',
              width: 50,
              height: 50,
            ),
          ),
        )),
      ),
      Expanded(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage(image),
              height: 100,
              width: 260,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    ],
  );
}

String formatDate(DateTime dateTime) {
  return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";
}

double getScrollViewBottomPadding(BuildContext context) {
  return MediaQuery.of(context).size.height *
          (bottomNavigationHeightPercentage) +
      bottomNavigationBottomMargin * (1.5);
}

double getScrollViewTopPadding(
    {required BuildContext context, required double appBarHeightPercentage}) {
  return MediaQuery.of(context).size.height *
      (appBarHeightPercentage + extraScreenContentTopPaddingForScrolling);
}

// String getTranslatedLabel(BuildContext context, String labelKey) {
//   return (AppLocalization.of(context)!.getTranslatedValues(labelKey) ??
//       labelKey)
//       .trim();
// }

bool isToadyIsInAcademicYear(DateTime firstDate, DateTime lastDate) {
  final currentDate = DateTime.now();

  return (currentDate.isAfter(firstDate) && currentDate.isBefore(lastDate)) ||
      isSameDay(firstDate) ||
      isSameDay(lastDate);
}

bool isSameDay(DateTime dateTime) {
  final currentDate = DateTime.now();
  return (currentDate.day == dateTime.day) &&
      (currentDate.month == dateTime.month) &&
      (currentDate.year == dateTime.year);
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: null,
                  children: <Widget>[
                    Center(
                      child: Column(children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Loading....",
                          style: TextStyle(color: Color(0xFF009247)),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
