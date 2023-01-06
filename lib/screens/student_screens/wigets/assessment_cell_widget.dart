import 'package:flutter/material.dart';

class AssessmentCellWidget extends StatelessWidget {
  final String title;
  final String image;
  final String author;
  final String date;
  final VoidCallback onClick;
  AssessmentCellWidget(
      {required this.title,
      required this.image,
      required this.author,
      required this.date,
      required this.onClick});
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                children: [

                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          author,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),

                      ],
                    ),
                  ),

                  GestureDetector(

                      onTap: onClick,

                      child:Material(
                          elevation: 2.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: const BorderSide(color: Colors.white)),

                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: const Text(
                                "View\nPDF",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                      ),
                  )


                ],
              ),
            )
        ),
      ),
    );
  }
}
