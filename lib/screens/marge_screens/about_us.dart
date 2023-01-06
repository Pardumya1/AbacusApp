import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutUs extends StatefulWidget {
  static const String routeName = '/AboutUs';

  const AboutUs({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _AboutUs();

}

class _AboutUs extends State<AboutUs> {

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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light
            ),
            title: const Text('About Abacus'),
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
                ),
              ),
            ),
            titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: buildBody(),

        ),
      ],
    );
  }

  showContent() {
    return SafeArea(
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

         Expanded(
            flex: 1,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      image: DecorationImage(
                          image: AssetImage("images/background.png"),
                          fit: BoxFit.cover
                      )
                  ),

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("Abacus is a simple tool or a hardware used for performing rapid arithmetic calculations."
                              "Calculation based on abacus was invented in the ancient times and now widely used as a brain development programme."
                              "It consists of a rectangular frame holding a number of vertically arranged rods, on which beads slide up and down.",
                              textAlign: TextAlign.start,
                              style: TextStyle(decoration: TextDecoration.none,
                                  fontSize: 14.0, color: Color(0xFF47473F),
                                  fontFamily: "Montserrat", fontWeight: FontWeight.w500)
                          ),
                        ),

                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: const EdgeInsets.only(left: 20, right: 20),

                          child:Image.asset(
                          "images/about_abacus_icon.png",
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                        ),),

                        Container(
                            margin: const EdgeInsets.only(bottom: 5, left: 20, top:25),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Value of Beads",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                  color: Colors.black),
                            )),

                        /*    five bead    */
                        Container(
                          margin: const EdgeInsets.only(left: 20,),
                          child: const Text("The upper bead has the value of 5 and the lower beads have the value of 1 each.",
                              textAlign: TextAlign.start,
                              style: TextStyle(decoration: TextDecoration.none,
                                  fontSize: 14.0, color: Color(0xFF47473F),
                                  fontFamily: "Montserrat", fontWeight: FontWeight.w500)
                          ),
                        ),

                        /*    alert images    */
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.only(top:20,bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Image.asset(
                                "images/rule_image.png",
                                height: 120,
                                width: 100,
                                fit: BoxFit.contain,
                              ),

                              Image.asset(
                                "images/rule_image1.png",
                                height: 120,
                                width: 100,
                                fit: BoxFit.contain,
                              ),

                            ],
                          ),

                        ),

                        /*    ten bead        */
                        Container(
                          margin: const EdgeInsets.only(left: 20,),
                          child: const Text("The upper bead has the value of 50 and lower beads have the value of 10 each.",
                              textAlign: TextAlign.start,
                              style: TextStyle(decoration: TextDecoration.none,
                                  fontSize: 14.0, color: Color(0xFF47473F),
                                  fontFamily: "Montserrat", fontWeight: FontWeight.w500)
                          ),
                        ),

                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.only(top:20,bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "images/ten1.png",
                                height: 120,
                                width: 100,
                                fit: BoxFit.contain,
                              ),

                              Image.asset(
                                "images/ten2.png",
                                height: 120,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),

                        ),

                        /*    100 bead    */
                        Container(
                          margin: const EdgeInsets.only(left: 20,),
                          child: const Text("The upper bead has the value of 500 and lower beads have the value of 100 each.",
                              textAlign: TextAlign.start,
                              style: TextStyle(decoration: TextDecoration.none,
                                  fontSize: 14.0, color: Color(0xFF47473F),
                                  fontFamily: "Montserrat", fontWeight: FontWeight.w500)
                          ),
                        ),

                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.only(top:20,bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Image.asset(
                                "images/hundred1.png",
                                height: 120,
                                width: 100,
                                fit: BoxFit.contain,
                              ),

                              Image.asset(
                                "images/hundred2.png",
                                height: 120,
                                width: 100,
                                fit: BoxFit.contain,
                              ),

                            ],
                          ),

                        )

                      ])
                )
            ),
          ),

        ],
      ),
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
}

