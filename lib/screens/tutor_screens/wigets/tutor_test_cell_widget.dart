import 'package:flutter/material.dart';

class TutorTestCellWidget extends StatelessWidget {
  final String title;
  final String image;
  final String author;
  final String date;
  final VoidCallback onClick;
  TutorTestCellWidget(
      {required this.title,
      required this.image,
      required this.author,
      required this.date,
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
                    children: const [
                      Text(
                        "Test Name",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hello",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Date : 12-12-2022",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Time : 2:04 PM",
                        style: TextStyle(
                          fontSize: 16,
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
