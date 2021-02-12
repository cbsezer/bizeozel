import 'package:bizeozel/view-model/Global_variables.dart';
import 'package:bizeozel/view-model/authentication.dart';
import 'package:bizeozel/view-model/loader.dart';
import 'package:bizeozel/views/AuthenticationPages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter/services.dart';

import 'forgotPassword.dart';


class MyPageView extends StatefulWidget {
  MyPageView({Key key}) : super(key: key);

  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
 final Authentication _authentication = Authentication();
 final TextEditingController _emailKayit = TextEditingController();
 final TextEditingController _emailGiris = TextEditingController();
 final TextEditingController _passwordKayit = TextEditingController();
 final TextEditingController _passwordKayitAgain = TextEditingController();
  final TextEditingController _passwordGiris = TextEditingController();
 final TextEditingController _fullname = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

 

  PageController _pageController;

  void initState() {
    super.initState();
    _pageController = PageController();
  }

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
          height:context.height,
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
                            height:context.dynamicHeight(0.85),
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
                                          duration:
                                              Duration(milliseconds: 750),
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
                                  padding:  context.horizontalPaddingLow,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 90,
                                            width: 100,
                                            child: AnimatedDrawing.svg(
                                              'assets/images/loginimg.svg',
                                              height:context.height<
                                                      540
                                                  ? 80
                                                  : 100,
                                              run: run,
                                              duration:
                                                   Duration(seconds: 8),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height:context.height
                                        <
                                                540
                                            ? 10
                                            : 30),
                                Container(
                                  height:context.height <
                                          600
                                      ? context.height *
                                          0.4
                                      : context.height *
                                          0.45,
                                  child: Center(
                                    child: Form(
                                      key: _formKey2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          _buildName(),
                                          _buildEmailKayit(),
                                          _buildPasswordKayit(),
                                          _buildPasswordKayitOnay(),
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
                            width:context.dynamicWidth(0.9),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/whitespace.png',
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0,
                                      top:
                                         context.height >
                                                  700
                                              ? 20
                                              : 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 90,
                                            width: 100,
                                            child: AnimatedDrawing.svg(
                                              'assets/images/loginimg.svg',
                                              height: 100,
                                              run: run,
                                              duration:
                                                  Duration(seconds: 8),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height:context.dynamicHeight(0.24),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: context.height <
                                                540
                                            ? 5
                                            : 20.0,
                                      ),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _buildEmailGiris(),
                                            _buildPasswordGiris(),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ForgotPassword()));
                                                },
                                                child:
                                                    _buildForgotPasswordBtn())
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top:context.height >
                                            700
                                        ? 0
                                        : 10,
                                    right:
                                       context.height<
                                                540
                                            ? 5
                                            : 25.0,
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
                                      duration:
                                          const Duration(milliseconds: 750),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right:context.height >
                                                700
                                            ? 10
                                            : 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
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
   Widget _buildEmailGiris() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 50,
      child: TextFormField(
          controller: _emailGiris,
          keyboardType: TextInputType.emailAddress,
          validator: (String oge) {
            if (oge.isEmpty) {
              return 'Mail adresi boş bırakılamaz.';
            }
            if (!RegExp(
                    "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                .hasMatch(oge)) {
              return 'Geçerli bir email giriniz';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'E-mail',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: Icon(Icons.alternate_email, color: Colors.grey),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(40),
            FilteringTextInputFormatter.deny(RegExp('[ -]')),
          ]),
    );
  }

  Widget _buildEmailKayit() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 50,
      child: TextFormField(
          controller: _emailKayit,
          keyboardType: TextInputType.emailAddress,
          validator: (oge) {
            if (oge.isEmpty) {
              return 'Mail adresi boş bırakılamaz.';
            }
            if (!RegExp(
                    "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                .hasMatch(oge)) {
              return 'Geçerli bir email giriniz';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'E-mail',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: Icon(Icons.alternate_email, color: Colors.grey),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(40),
            FilteringTextInputFormatter.deny(RegExp('[ -]')),
          ]),
    );
  }

  Widget _buildName() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 50,
      child: TextFormField(
        controller: _fullname,
        keyboardType: TextInputType.name,
        validator: (oge) {
          if (oge.isEmpty) {
            return 'İsim bilgisi boş bırakılamaz.';
          } else if (oge.length < 2) {
            return 'İsim çok kısa.';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'İsim',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          suffixIcon: Icon(Icons.person, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildPasswordKayit() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 50,
      child: TextFormField(
          controller: _passwordKayit,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          validator: (oge) {
            if (oge.isEmpty) {
              return 'Parola bilgisi boş bırakılamaz.';
            } else if (oge.length < 8) {
              return 'Şifreniz en az 8 haneli olmalıdır.';
            }

            return null;
          },
          decoration: InputDecoration(
            hintText: 'Parola',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: Icon(Icons.lock, color: Colors.grey),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
            FilteringTextInputFormatter.deny(RegExp('[ -]')),
          ]),
    );
  }

  Widget _buildPasswordKayitOnay() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 50,
      child: TextFormField(
          controller: _passwordKayitAgain,
          validator: (oge) {
            if (oge.isEmpty) {
              return 'Parola onay bilgisi boş bırakılamaz.';
            } else if (oge.length < 8) {
              return 'Şifreniz en az 8 haneli olmalıdır.';
            }

            return null;
          },
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Parola',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: Icon(Icons.lock, color: Colors.grey),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
            FilteringTextInputFormatter.deny(RegExp('[ -]')),
          ]),
    );
  }

  Widget _buildPasswordGiris() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 50,
      child: TextFormField(
          controller: _passwordGiris,
          obscureText: true,
          validator: (oge) {
            if (oge.isEmpty) {
              return 'Parola bilgisi boş bırakılamaz.';
            } else if (oge.length < 8) {
              return 'Şifreniz en az 8 haneli olmalıdır.';
            }

            return null;
          },
          decoration: InputDecoration(
            hintText: 'Parola',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: Icon(Icons.lock, color: Colors.grey),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
            FilteringTextInputFormatter.deny(RegExp('[ -]')),
          ]),
    );
  }

  Widget _buildLoginBtn() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState.validate()) {
          return girisYap();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width:context.width < 540 ? 100 : 120,
        height:context.height < 540 ? 42 : 50,
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
          userSignUp();
        }
         await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeS()), (route) => false);
      },
      child: Container(
        alignment: Alignment.center,
        width: context.width < 540 ? 100 : 120,
        height:context.height < 540 ? 42 : 50,
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
        left:context.height < 540 ? 15 : 20.0,
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

  void userSignUp() async {
    fullName = _fullname.text;
    email = _emailKayit.text.trim();

    if (_passwordKayit.text != _passwordKayitAgain.text) {
      await Fluttertoast.showToast(msg: 'Şifreler Uyuşmuyor!');
    } else if (_fullname.text.length <= 1) {
      await Fluttertoast.showToast(msg: 'İsim bilgisi en az 2 karakter olmalıdır');
    } else {
      var kayit = await _authentication.kullaniciKayit(
          _emailKayit.text.trim(), _passwordKayit.text);
      if (kayit.runtimeType == FirebaseAuthException) {
        print(kayit.runtimeType);
        if (kayit.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          await Fluttertoast.showToast(msg: 'Mail adresi kullanılıyor.');
        }
      } else if (kayit == null) {
        await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => loader()),
            (Route<dynamic> route) => true);
        final user = FirebaseAuth.instance.currentUser;
        userID = user.uid;
        await FirebaseFirestore.instance.collection('Users').doc(userID).set({
          'userID': userID,
          'name': fullName,
          'biography': 'Gülümsemek en güzel makyajdır ❤',
          'email': email,
          'userType': 'Çıtır',
          'userPhoto': '',
          
          'shares': [],
          'signUpDate': DateTime.now(),
          
        });
        print(kayit.runtimeType);
        Future.delayed(Duration(milliseconds: 2000), () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeS()),
              (Route<dynamic> route) => false);
          bottomNavBarSelectedIndex = 0;
        });
      }
    }
  }

  void girisYap() async {
    var giris = await _authentication.giris(
        _emailGiris.text.trim(), _passwordGiris.text, context);
    if (giris.runtimeType == FirebaseAuthException) {
      if (giris.code == 'user-not-found') {
        await Fluttertoast.showToast(
            msg: 'Böyle bir kullanıcı yok. Kullanıcı silinmiş olabilir.');
      } else if (giris.code == 'user-disabled') {
        await Fluttertoast.showToast(msg: 'Kullanıcı engellendi.');
      } else if (giris.code == 'wrong-password') {
        await Fluttertoast.showToast(msg: 'Parola geçersiz.');
      }
    } else if (giris == null) {
      print(giris.runtimeType);
      await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => loader()),
          (Route<dynamic> route) => true);

      await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeS()),
          (Route<dynamic> route) => false);
      bottomNavBarSelectedIndex = 0;
    }
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
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}

class AppClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path =  Path();

    double cornerSize = 25;
    double diagonalHeight = 180;

    path.moveTo(0, cornerSize * 1.5);
    path.lineTo(0, size.height - cornerSize);

    path.quadraticBezierTo(0, size.height, cornerSize, size.height);
    path.lineTo(size.width - cornerSize, size.height);

    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - cornerSize);
    path.lineTo(size.width, diagonalHeight + cornerSize);
    path.quadraticBezierTo(size.width, diagonalHeight, size.width - cornerSize,
        diagonalHeight * .9);
    path.lineTo(cornerSize * 2, cornerSize);
    path.quadraticBezierTo(0, 0, 0, cornerSize * 1.5);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
