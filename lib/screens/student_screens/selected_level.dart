import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PlayGamesListScreen.dart';

class SelectedLevel extends StatefulWidget {
  static const String routeName = '/SelectedLevel';
  final String levelStatus;
  final String levelId;
  final String name;

  const SelectedLevel({super.key, required this.levelStatus, required this.levelId, required this.name});

  @override
  State<StatefulWidget> createState() => _SelectedLevel();

}

class _SelectedLevel extends State<SelectedLevel> {

  final _controller = PageController();
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  int dialogIndex = 0;

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
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light
            ),
            title: Text(widget.name),
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
                  child: Text("Let's input number to abacus",
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
                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                       image: const DecorationImage(
                           image: AssetImage("images/background.png"),
                           fit: BoxFit.cover
                       )
                   ),

                   child: Container(
                       decoration: const BoxDecoration(image: DecorationImage(
                         image: AssetImage("images/selected_level_img.png"),
                         alignment: Alignment.bottomRight,
                       )),

                       child: Container(
                         alignment: Alignment.topCenter,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             rulesButton(),
                             startButton()
                           ],
                         ),
                       )
                   ),

                 )

              )

            ],
          )
      ),

    );

  }

  /*       Rule Button Function      */
  rulesButton() {
    return Container(
      margin: EdgeInsets.only(top: 80),
      width: 320.0,
      height: 50.0,
      child: ElevatedButton(

          style: ElevatedButton.styleFrom(
              backgroundColor : const Color(0xFF063464),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: const BorderSide(color: Color(0xFF063464))),
              elevation: 6.0
          ),

          child: const Text(
            "Rules",
            style: TextStyle(
                fontFamily: "Montserrat", fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500
            ),
          ),
          onPressed: () {
            // showRulesAlert();

            showDialog(
                context: context,
                builder: (context) {
                  String btnText = "Cancel";
                  return StatefulBuilder(
                      builder : (context, setState){
                        return AlertDialog(
                          title: Text(
                            widget.name,
                            style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF063464),
                            ),
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 250, // 70% height
                                width: double.maxFinite,
                                child: PageView.builder(
                                  controller: _controller,
                                  itemCount: dialogList.length,
                                  itemBuilder: (BuildContext context, int index) {

                                    debugPrint("dialogIndex : $dialogIndex");

                                    dialogIndex = index;
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[

                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20, top: 10),
                                          child: Text(
                                            dialogList[index].title,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF063464),
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(bottom: 10),
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children:[

                                                  Image.asset(
                                                    dialogList[index].imageFirst,
                                                    width: 150,
                                                    height: 150,
                                                  ),
                                                  Image.asset(
                                                    dialogList[index].imageSecond,
                                                    width: 150,
                                                    height: 150,
                                                  ),

                                                ])
                                        ),

                                      ],
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:[

                                    Flexible(
                                      flex:1,
                                      child: ElevatedButton(
                                        onPressed: () {

                                          if(dialogIndex == 0){
                                            setState(() {
                                              btnText = "Cancel";
                                            });
                                            Navigator.pop(context);
                                          }else{
                                            setState(() {
                                              btnText = "Previous";
                                            });
                                            _controller.previousPage(
                                                duration: _kDuration, curve: _kCurve);
                                          }

                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF063464),
                                          // primary: Colors.transparent,

                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 50, ),
                                          elevation: 6.0,
                                        ),
                                        child: Text(btnText,
                                            style: const TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 18.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500)),
                                      ),),
                                    Flexible(
                                      flex:1,
                                      child: ElevatedButton(
                                        onPressed: () {

                                          debugPrint("dialogIndex : $dialogIndex");

                                          if(dialogIndex == 0){
                                            setState(() {
                                              btnText = "Cancel";
                                            });
                                          }
                                          else{
                                            setState(() {
                                              btnText = "Previous";
                                            });
                                          }

                                          _controller.nextPage(duration: _kDuration, curve: _kCurve);

                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF063464),
                                          // primary: Colors.transparent,

                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 50, ),
                                          elevation: 6.0,
                                        ),
                                        child: const Text("Next",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 18.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    )

                                  ]),
                            )
                          ],
                        );
                      });
                });
          }),
    );
  }

  /*       Start Button Function      */
  startButton() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: 320.0,
      height: 50.0,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: const BorderSide(color: Color(0xFF063464))),
              elevation: 6.0
          ),

          child: const Text(
            "Start",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF063464),
            ),
          ),

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlayGamesList(),
              ),
            );
          }),
    );
  }

}


/*   Item Data     */
class DialogModel{

  const DialogModel({required this.title, required this.imageFirst, required this.imageSecond});

  final String title;
  final String imageFirst;
  final String imageSecond;

}

List<DialogModel> dialogList = <DialogModel>[

  const DialogModel(title: 'The upper bead has the value of 5 and the lower beads have the value of 1 each.', imageFirst: "images/rule_image.png", imageSecond: "images/rule_image1.png"),
  const DialogModel(title: 'The upper bead has the value of 50 and lower beads have the value of 10 each.', imageFirst: "images/ten1.png", imageSecond: "images/ten2.png"),
  const DialogModel(title: 'The upper bead has the value of 500 and lower beads have the value of 100 each.', imageFirst: "images/hundred1.png", imageSecond: "images/hundred2.png"),

];



