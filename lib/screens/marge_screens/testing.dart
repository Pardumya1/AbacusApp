import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:touchable/touchable.dart';

class TestingScreen extends StatefulWidget {
  static const String routeName = '/TestingScreen';

  const TestingScreen({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _TestingScreen();

}

class _TestingScreen extends State<TestingScreen> {

  @override
  void initState() {

    print('You clicked BLUE circle');

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);

    super.initState();
  }

  @override
  void dispose() {

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

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
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark
            ),
            title: const Text('Abacus'),
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
                  color: Colors.black,
                ),
              ),
            ),
            titleTextStyle: const TextStyle(decoration: TextDecoration.none, fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            // Inner yellow container
            child: Container(
              // pass double.infinity to prevent shrinking of the painter area to 0.
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: CustomPaint(painter: AbacusPainter(context)),
          ),
          ),
        ),
      ],
    );
  }
}


class AbacusPainter extends CustomPainter {

  final BuildContext context ;
  AbacusPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {


    TouchyCanvas touchyCanvas = TouchyCanvas(context, canvas);

    var blueCircle = Offset(size.width / 2, size.height / 2 - 100);
    var greenCircle = Offset(size.width / 2, size.height / 2 + 100);

    touchyCanvas.drawCircle(blueCircle, 60, Paint()..color = Colors.blue, onTapDown: (_) {
      print('You clicked BLUE circle');
    });

    touchyCanvas.drawCircle(greenCircle, 30, Paint()..color = Colors.green, onLongPressStart: (_) {
      print('long pressed on GREEN circle');
    });

  }

  @override
  bool shouldRepaint(AbacusPainter oldDelegate) => true;
}








