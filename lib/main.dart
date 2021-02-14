import 'package:bizeozel/views/AuthenticationPages/models/UserModel.dart';
import 'package:bizeozel/views/AuthenticationPages/view/pageview.dart';
import 'package:bizeozel/views/AuthenticationPages/services/authentication.dart';
import 'package:bizeozel/views/PublicEducationPages/view/Location.dart';
import 'package:bizeozel/views/bottom-navbar/navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: Authentication().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.white),
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    if (user == null) {
      return MyPageView();
    } else {
      return HomeScreen();
    }
  }
}
