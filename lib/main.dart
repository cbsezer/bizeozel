
import 'package:bizeozel/views/AuthenticationPages/login.dart';
import 'package:bizeozel/views/AuthenticationPages/pageview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view-model/authentication.dart';
import 'view-model/openingFunctions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false
      home: MyPageView(),

    return StreamProvider<Userid>.value(
      value: Authentication().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.white),
        home: MainScreen(),
      ),

    );
  }
}
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userid>(context);
    if (user == null) {
      return MyPageView();
    } else {
      return FutureBuilder(
        future: pullUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return HomeS();
        },
      );
    }
  }
}



