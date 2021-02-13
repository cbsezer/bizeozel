import 'package:bizeozel/views/ActivityPages/view/share_activity.dart';
import 'package:bizeozel/views/ActivityPages/view/activity_dashboard.dart';
import 'package:bizeozel/views/Dashboard/view/main_dashboard.dart';
import 'package:bizeozel/views/ProfilePages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'nav_bar_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  TabController tabController;

  @override
  void initState() {
    _pageController.addListener(() {
      var currentIndex = _pageController.page.round();
      if (currentIndex != bottomNavBarSelectedIndex) {
        bottomNavBarSelectedIndex = currentIndex;
      }
      setState(() {});
    });
    super.initState();
  }

  void handleIndexChanged(int value) {
    if (value != bottomNavBarSelectedIndex) {
      setState(() {
        bottomNavBarSelectedIndex = value;
      });
    }
  }

  final List<Widget> _widgetOptions = <Widget>[
    MainDashboard(),
    AcitivityDashboard(),
    ActivityShare(),
    MainDashboard(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: bottomNavBarSelectedIndex,
        onTap: handleIndexChanged,
        items: [
          /// Main Dashboard
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Anasayfa'),
            selectedColor: Colors.pink,
          ),

          /// Activity Dashboard
          SalomonBottomBarItem(
            icon: Icon(
              FontAwesomeIcons.solidHeart,
              size: 20,
            ),
            title: Text('Etkinlikler'),
            selectedColor: Colors.red,
          ),

          /// Halk Eğitim
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.school, size: 20),
            title: Text('Kurslar'),
            selectedColor: Colors.orange,
          ),

          /// Work Offers
          SalomonBottomBarItem(
            icon: Icon(Icons.work),
            title: Text('İş İlanları'),
            selectedColor: Colors.teal,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Profil'),
            selectedColor: Colors.blueAccent,
          ),
        ],
      ),
      body: _widgetOptions.elementAt(bottomNavBarSelectedIndex),
    );
  }
}
