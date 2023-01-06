
import 'package:abacus_app/screens/student_screens/selected_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class GameLevel extends StatefulWidget {
  static const String routeName = '/GameLevel';

  @override
  State<StatefulWidget> createState() => _GameLevel();

}

class _GameLevel extends State<GameLevel> {

  int selectedCard = 0;
  
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
          //color set to transperent or set your own color
        )
    );

    super.dispose();
  }

  final List<Map> levels =
  List.generate(10, (index) => {"id": index, "name": "Level $index"}).toList();

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
            title: const Text("Abacus Level"),
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
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Text("Introduction to Addition and Subtraction",
                      textAlign: TextAlign.center,
                      style: TextStyle(decoration: TextDecoration.none, fontSize: 16.0, color: Colors.white, fontFamily: "Montserrat", fontWeight: FontWeight.w600)
                  )
              ),

              Expanded(
                 child:Container(
                   margin: EdgeInsets.only(top: 40),
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
                         padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
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
                                 // ontap of each card, set the defined int to the grid view index
                                 selectedCard = index;
                                 // Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedLevel(),),);
                               });
                             },
                             child: Container(
                                 padding: const EdgeInsets.only(left: 20, right: 20),
                                 decoration: BoxDecoration(
                                     color: selectedCard == index ? const Color(
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
                                       color: selectedCard == index ? Colors.white : null,
                                       fit: BoxFit.fill,
                                     ),
                                     SizedBox(width: 20),
                                     Text(
                                       levels[index]["name"],
                                       style: TextStyle(
                                           decoration: TextDecoration.none,
                                           fontSize: 16,
                                           fontWeight: FontWeight.w500,
                                           fontFamily: "Montserrat",
                                           color: selectedCard == index ? Colors.white : Color(
                                               0xff006e3c)
                                       )
                                     )

                                   ]
                                 )
                           ),
                           );
                         }
                     )

                 )

              )

            ],
          )
      ),
    );

  }

}

