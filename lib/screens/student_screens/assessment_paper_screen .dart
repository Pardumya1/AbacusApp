
import 'package:abacus_app/screens/student_screens/wigets/assessment_cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../marge_screens/PDFScreen.dart';


class Post {
  final String title;
  final String image;
  final String author;
  final String date;

  Post({required this.title, required this.image, required this.author, required this.date});
}


class AssessmentPaperScreen extends StatefulWidget {

  static const String routeName = '/AssessmentPaperScreen';
  const AssessmentPaperScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AssessmentPaperScreen();

}

class _AssessmentPaperScreen extends State<AssessmentPaperScreen> {

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

    super.dispose();
  }


  final data = [
    Post(
      image: "images/paper_icon.png",
      title: 'Assessment Paper',
      author: 'Regular Level 2',
      date: '25 Mar 2020',
    ),
  ];


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light
        )
    );

    return Stack(
      children: <Widget>[

        Image.asset(
          "images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),

        MaterialApp(
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.light
                ),
                title: const Text('Level Assessment Paper'),
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

                titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: "Montserrat"),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,

                bottom: const TabBar(
                  tabs: [
                    Tab(text: "Assessment Paper"),
                    Tab(text: "Submitted Paper")
                  ],
                ),
              ),
              body: buildBody(),
            ),
          ),
        ),
      ]

    );
  }

  Widget buildBody() {
    return SizedBox(
        width: double.infinity,

        child: Stack(
            children: [

              const Image(
                  image: AssetImage("images/home_bg.png"),
                  fit: BoxFit.fill),
              showContent()

            ]

        )

    );

  }

  showContent() {
    return SafeArea(

      child: Container(

        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF1F0F0),
          border: Border.all(
            color: Color(0xBBFAFAFA),
          ),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),

        ),
        child:TabBarView(
          children: [
            listViewSection(),
            listViewSection(),
          ],
        ),
      ),

    );

  }

  listViewSection(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final post = data[index];
          return AssessmentCellWidget(
              title: post.title,
              image: post.image,
              author: post.author,
              date: post.date,
              onClick: () {

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PDFScreen(),
                  ),
                );


              });
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }

}

