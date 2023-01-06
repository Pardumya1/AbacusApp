import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'assessment_paper_screen .dart';

class LevelScreen extends StatefulWidget {
  static const String routeName = '/LevelScreen';

  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LevelScreen();

}

class _LevelScreen extends State<LevelScreen> {
  
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

  List<dynamic> levels = json.decode("""
[
    {
        "id": 1,
        "name": "Elementary Level 1",
        "status": "1"
    },
    {
        "id": 2,
        "name": "Elementary Level 2",
        "status": "0"
    },
    {
        "id": 3,
        "name": "Elementary Level 3",
        "status": "0"
    },
    {
        "id": 4,
        "name": "Elementary Level 4",
        "status": "0"
    },
    {
        "id": 5,
        "name": "Elementary Level 5",
        "status": "0"
    },
    {
        "id": 6,
        "name": "Elementary Level 6",
        "status": "0"
    },
    {
        "id": 7,
        "name": "Regular Level 1",
        "status": "0"
    },
    {
        "id": 8,
        "name": "Regular Level 2",
        "status": "0"
    },
    {
        "id": 9,
        "name": "Regular Level 3",
        "status": "0"
    },
    {
        "id": 10,
        "name": "Regular Level 4",
        "status": "0"
    },
    {
        "id": 11,
        "name": "Regular Level 5",
        "status": "0"
    },
    {
        "id": 12,
        "name": "Regular Level 6",
        "status": "0"
    },
    {
        "id": 13,
        "name": "Advanced Level 1",
        "status": "0"
    },
    {
        "id": 14,
        "name": "Advanced Level 2",
        "status": "0"
    },
    {
        "id": 15,
        "name": "Advanced Level 3",
        "status": "0"
    },
    {
        "id": 16,
        "name": "Advanced Level 4",
        "status": "0"
    },
    {
        "id": 17,
        "name": "Grand master Level 1",
        "status": "0"
    },
    {
        "id": 18,
        "name": "Grand master Level 2",
        "status": "0"
    },
    {
        "id": 19,
        "name": "Grand master Level 3",
        "status": "0"
    }
]
    """);

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
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light
            ),
            title: const Text("My Level"),
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
          ),
          body:  buildBody()
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Expanded(
             child:Container(
               margin: const EdgeInsets.only(top:20),
               padding: const EdgeInsets.only(top:10,bottom: 20),
               decoration: BoxDecoration(
                   color: Colors.white,
                   border: Border.all(
                     color: Colors.white,//Radius.circular(20)
                   ),
                   image: const DecorationImage(
                       image: AssetImage("images/background.png"),
                       fit: BoxFit.cover
                   )
               ),

                 child: GridView.builder(
                     padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                     scrollDirection: Axis.vertical,
                     shrinkWrap: true,
                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         crossAxisSpacing: 20,
                         mainAxisSpacing: 20,
                         childAspectRatio: 6/2
                     ),
                     itemCount: levels.length,
                     itemBuilder: (BuildContext ctx, index) {
                       return GestureDetector(
                         onTap: () {
                           setState(() {

                             if(levels[index]["status"] == "1"){
                               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const AssessmentPaperScreen()));
                             }

                           });
                         },
                         child: Container(

                             padding: const EdgeInsets.only(left: 10, right: 10),
                             decoration: BoxDecoration(
                                 color: levels[index]["status"] == "1" ? const Color(
                                     0xff006e3c) : Colors.white,
                                 border: Border.all(color: const Color(0xFFEEEEE9), // Set border color
                                     width: 1.0),
                                 borderRadius: BorderRadius.circular(5)
                             ),

                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children:[
                                 Image.asset(
                                   'images/untick_level.png',
                                   width: 24,
                                   height: 24,
                                   color: levels[index]["status"] == "1" ? Colors.white : null,
                                   fit: BoxFit.fill,
                                 ),

                                 const SizedBox(width: 10),

                                 Flexible(child: Text(
                                     levels[index]["name"],
                                     style: TextStyle(
                                         decoration: TextDecoration.none,
                                         fontSize: 16,
                                         fontWeight: FontWeight.w500,
                                         fontFamily: "Montserrat",
                                         color: levels[index]["status"] == "1" ? Colors.white : const Color(
                                             0xff006e3c)
                                     )
                                 ))

                               ]
                             )

                         ),
                       );
                     }
                 )

             )

          )

        ],
      ),
    );

  }

}

