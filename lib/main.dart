import 'package:crusher/Provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/Utils.dart';
import 'Screens/SplashScreen.dart';
import 'Service/Network.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider<WebServices>(create: (_) => WebServices()),
    ChangeNotifierProvider<Utils>(create: (_) => Utils()),
    ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider()),
    ],
        child: MaterialApp(
      title: 'Crusher',
      home: SplashScreen(),
    ));
  }
}
