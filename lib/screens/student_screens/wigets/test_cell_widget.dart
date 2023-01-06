import 'package:flutter/material.dart';

class TestCellWidget extends StatelessWidget {
  final String title;
  final String image;
  final String level;
  final String date;
  final String startTime;
  final String type;
  final VoidCallback onClick;
  const TestCellWidget(
      {super.key, required this.title,
      required this.image,
      required this.level,
      required this.date,
      required this.startTime,
      required this.type,
      required this.onClick});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
          margin: const EdgeInsets.only(left:15, right: 15),
          child: Material(
            elevation: 1.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: const BorderSide(color: Colors.white)),
            child: Padding(
              padding: const EdgeInsets.only(left:10, right: 10, top: 10, bottom: 10),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Test Name",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),


                  type == "0" ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Date : $date",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Time : $startTime",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ) :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Result Status",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        date == "0" ? "Pending" : "Uploaded",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            )

        )

      ),
    );
  }
}
