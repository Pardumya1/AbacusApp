import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../utils/screen.dart';


class VirtualAbacus extends StatefulWidget {


  static const String routeName = '/VirtualAbacus';

  const VirtualAbacus({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VirtualAbacus();

}

class _VirtualAbacus extends State<VirtualAbacus> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(

            height: SizeConfig.blockSizeVertical*100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/background.png"),
                  fit: BoxFit.fill
              ),
            ),

            child: SafeArea(

                child:Container(

                  alignment: Alignment.center,
                  height: SizeConfig.blockSizeVertical*35,
                  width: SizeConfig.blockSizeHorizontal*180,

                  child: InAppWebView(
                    onWebViewCreated: (InAppWebViewController controller) {
                      var uri = "assets/index.html";
                      controller.loadFile(assetFilePath: uri);
                    },
                  ),

                )

            )
        ),
      ),
    );
  }

}




