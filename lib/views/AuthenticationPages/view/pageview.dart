import 'package:bizeozel/views/AuthenticationPages/services/LoginServices.dart';
import 'package:bizeozel/views/AuthenticationPages/services/SignUpServices.dart';
import 'package:bizeozel/views/AuthenticationPages/services/loader.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter/services.dart';
import 'forgotPassword.dart';

class MyPageView extends StatefulWidget {
  MyPageView({Key key}) : super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final TextEditingController _emailKayit = TextEditingController();
  final TextEditingController _emailGiris = TextEditingController();
  final TextEditingController _passwordKayit = TextEditingController();
  final TextEditingController _passwordKayitAgain = TextEditingController();
  final TextEditingController _passwordGiris = TextEditingController();
  final TextEditingController _fullname = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  PageController _pageController;
  final SignUpService _services = SignUpService();
  final LoginPageServices _login = LoginPageServices();

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
    return Stack(
      children: [
        Image.asset(
          'assets/images/background.jpg',
          height: context.height,
          width: context.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.transparent,
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              children: [
                Stack(
                  children: [
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: SingleChildScrollView(
                            child: _mainLogin(context, run),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Center(
                        child: _mainLoginClip(context, run),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _mainLoginClip(BuildContext context, bool run) {
    return SingleChildScrollView(
      child: ClipPath(
        clipper: AppClipper(),
        child: Container(
          width: context.dynamicWidth(0.85),
          height: context.dynamicHeight(0.85),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: context.horizontalPaddingLow,
                child: InkWell(
                  onTap: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        0,
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Icon(
                    FontAwesomeIcons.arrowAltCircleUp,
                    color: Color(0xffffb8b8),
                    size: 26,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: context.horizontalPaddingLow,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 90,
                          width: 100,
                          child: AnimatedDrawing.svg(
                            'assets/images/loginimg.svg',
                            height: context.height < 540 ? 80 : 100,
                            run: run,
                            duration: Duration(seconds: 8),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height < 540 ? 10 : 30),
              Container(
                height: context.height < 600 ? context.height * 0.4 : context.height * 0.45,
                child: Center(
                  child: Form(
                    key: _formKey2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        inputBoxAuth(_fullname, context, 'İsim', TextInputType.text, () {
                          _services.emailValidator;
                        }, Icons.person),
                        inputBoxAuth(_emailKayit, context, 'E-mail', TextInputType.emailAddress, () {
                          _services.emailValidator;
                        }, Icons.alternate_email),
                        inputBoxAuth(_passwordKayit, context, 'Parola', TextInputType.visiblePassword, () {
                          _services.passwordValidator;
                        }, Icons.lock),
                        inputBoxAuth(_passwordKayitAgain, context, 'Parola', TextInputType.visiblePassword, () {
                          _services.repeatPasswordValidator;
                        }, Icons.lock),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: context.horizontalPaddingLow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          loader();
                        },
                        child: _buildSignUpBtn()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainLogin(BuildContext context, bool run) {
    return Container(
      height: context.dynamicHeight(0.8),
      width: context.dynamicWidth(0.9),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/whitespace.png',
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, top: context.height > 700 ? 20 : 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 90,
                      width: 100,
                      child: AnimatedDrawing.svg(
                        'assets/images/loginimg.svg',
                        height: 100,
                        run: run,
                        duration: Duration(seconds: 8),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: context.dynamicHeight(0.24),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.height < 540 ? 5 : 20.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      inputBoxAuth(_emailGiris, context, 'E-mail', TextInputType.emailAddress, () {
                        _services.emailValidator;
                      }, Icons.alternate_email),
                      inputBoxAuth(_passwordGiris, context, 'Parola', TextInputType.visiblePassword, () {
                        _services.passwordValidator;
                      }, Icons.lock),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                          },
                          child: _buildForgotPasswordBtn())
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: context.height > 700 ? 0 : 10,
              right: context.height < 540 ? 5 : 25.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildLoginBtn(),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              _pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeIn,
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: context.height > 700 ? 10 : 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    FontAwesomeIcons.arrowAltCircleDown,
                    color: Color(0xffffb8b8),
                    size: 26,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputBoxAuth(TextEditingController controller, BuildContext context, String string,
      TextInputType textInputType, validator, suffixIcon) {
    return Container(
      height: 50,
      width: context.width * 0.75,
      child: Center(
        child: TextFormField(
          obscureText: (string == 'Parola') ? true : false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return validator();
          },
          keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: string,
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: Icon(suffixIcon, color: Colors.grey),
          ),
          autofocus: true,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState.validate()) {
          return _login.signIn(context, _emailGiris.text.trim(), _passwordGiris.text);
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: context.width < 540 ? 100 : 120,
        height: context.height < 540 ? 42 : 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Color(0xffffb8b8),
              Color(0xfffdd0d0),
            ])),
        child: Text(
          'Giriş Yap!',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
      ),
    );
  }

  Widget _buildSignUpBtn() {
    return InkWell(
      onTap: () async {
        if (!_formKey2.currentState.validate()) {
          return SizedBox();
        } else {
          _services.signUp(
              context, _emailKayit.text.trim(), _passwordKayit.text, _passwordKayitAgain.text, _fullname.text);
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: context.width < 540 ? 100 : 120,
        height: context.height < 540 ? 42 : 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Color(0xffffb8b8),
              Color(0xfffdd0d0),
            ])),
        child: Text(
          'Kayıt Ol!',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Padding(
      padding: EdgeInsets.only(
        left: context.height < 540 ? 15 : 20.0,
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          'Şifremi  Unuttum?',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 150);
    // path.quadraticBezierTo(size.width, size.height, size.width, size.height-25);
    path.lineTo(size.width, size.height);
    //path.quadraticBezierTo(0, 0, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => ClampingScrollPhysics();
}

class AppClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    double cornerSize = 25;
    double diagonalHeight = 180;

    path.moveTo(0, cornerSize * 1.5);
    path.lineTo(0, size.height - cornerSize);

    path.quadraticBezierTo(0, size.height, cornerSize, size.height);
    path.lineTo(size.width - cornerSize, size.height);

    path.quadraticBezierTo(size.width, size.height, size.width, size.height - cornerSize);
    path.lineTo(size.width, diagonalHeight + cornerSize);
    path.quadraticBezierTo(size.width, diagonalHeight, size.width - cornerSize, diagonalHeight * .9);
    path.lineTo(cornerSize * 2, cornerSize);
    path.quadraticBezierTo(0, 0, 0, cornerSize * 1.5);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
