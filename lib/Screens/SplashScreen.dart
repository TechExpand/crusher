


import 'package:crusher/Service/Network.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';

import 'Crusher/home.dart';
import 'IntroPages/intro.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var network = Provider.of<WebServices>(context, listen: false);
    network.setPath('null');
    checkForUpdate();
    Future.delayed(Duration(seconds: 5), () async {
      return decideFirstWidget();
    });
  }


  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if(info.updateAvailability == UpdateAvailability.updateAvailable){
        InAppUpdate.performImmediateUpdate()
            .catchError((e){
          print(e);
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<dynamic> decideFirstWidget() async {
    final box = GetStorage();
    var network = Provider.of<WebServices>(context, listen: false);


  var  token = box.read('token');
    var  type = box.read('type');

    if (token == null || token == 'null' || token == '' || token.isEmpty) {
      return Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return IntroPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
            (route) => false,
      );
    } else {
      network.setToken(box.read('token'));
      return Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return Home(); //SignUpAddress();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
            (route) => false,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Stack(
        children: [
             Center(child: ColorFiltered(
               colorFilter: ColorFilter.mode(
                 Colors.grey,
                 BlendMode.saturation,
               ),
               child: Container(
                   height: MediaQuery.of(context).size.height/1.4,
                   width: MediaQuery.of(context).size.width,
                   child: Image.asset('assets/images/edo.png', fit: BoxFit.cover,)),
             )),


          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.96),
            width: MediaQuery.of(context).size.width,
            child: Text(''),
          ),
          Center(child: Image.asset('assets/images/edo.png', width: 250, height: 250,)),
        ],
      ),
    );
  }
}
