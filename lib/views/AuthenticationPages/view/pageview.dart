import 'package:bizeozel/views/AuthenticationPages/view/login_page.dart';
import 'package:bizeozel/views/AuthenticationPages/view/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'clipper.dart';

class MyPageView extends StatefulWidget {
  MyPageView({Key key}) : super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var run = true;
    return Stack(children: [
      Image.asset('assets/images/background.jpg', height: context.height, width: context.width, fit: BoxFit.cover),
      Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            children: [
              Stack(children: [
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: SingleChildScrollView(
                        child: loginPage(context, run, () {
                          _pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 750), curve: Curves.easeIn);
                        }),
                      ),
                    ),
                  ),
                ),
              ]),
              Stack(children: [
                Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: SignUp(() {
                        _pageController.animateToPage(0,
                            duration: Duration(milliseconds: 750), curve: Curves.easeInOut);
                      }),
                    ))
              ]),
            ],
          ),
        ),
      ),
    ]);
  }
}
