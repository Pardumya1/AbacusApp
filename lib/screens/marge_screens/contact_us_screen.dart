import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ContactUsScreen extends StatefulWidget {

  static const String routeName = '/ContactUsScreen';
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactUsScreen();

}

class _ContactUsScreen extends State<ContactUsScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
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
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark
            ),
            title: const Text('Contact Us'),
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
            titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Color(0xFF47473F), fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),

          body: Container(
              padding: const EdgeInsets.only(top: 10),
              child: SafeArea(
                  child: Column(
                    children: [

                      QrImage(
                        data: 'https://www.google.com/maps/dir//3rd+St+%26+Dr+Radha+Krishnan+Salai+Jagadambal+Colony,+Dwarka+Colony,+Mylapore+Chennai,+Tamil+Nadu+600004/@13.0442994,80.2697777,15z/data=!4m8!4m7!1m0!1m5!1m1!1s0x3a52662ec294ef97:0x4c5421c972e10574!2m2!1d80.2697777!2d13.0442994',
                        version: QrVersions.auto,
                        size: 320,
                        gapless: false,
                      ),

                      informationFunction()

                    ],

                  )

              )
          ),

        ),
      ],
    );
  }


  /*      Information       */
  informationFunction(){
    return Container(
      margin: const EdgeInsets.all(20),

      child: Column(
        children: [

          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 20,bottom: 10),
            child: const Text(
              "Corporate Head Office Chennai",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: Colors.black),
            ),
          ),

          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(right: 10,),
                  child: Image.asset(
                    "images/mail_icon.png",
                    width: 60,
                    height: 60,
                  ),
                ),
                const Expanded(
                    child: Text(
                      "contact@playabacusindia.com",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          fontFamily: "Montserrat",
                          color: Colors.black),
                    )),
              ]),

          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 20,bottom: 20),
            child: const Text(
              "Working Hours",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: Colors.black),
            ),
          ),

          Column(
            children: [

              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Mon – Friday : 9:30am – 5:30pm",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 16,
                      fontFamily: "Montserrat",
                      color: Colors.black),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 10,bottom: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Sat : 9.30am – 2:00pm",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 16,
                      fontFamily: "Montserrat",
                      color: Colors.black),
                ),
              ),

            ],
          ),


        ],

      )

    );

  }

}

