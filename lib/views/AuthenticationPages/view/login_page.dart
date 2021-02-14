import 'package:bizeozel/views/AuthenticationPages/services/LoginServices.dart';
import 'package:bizeozel/views/AuthenticationPages/view/forgotPassword.dart';
import 'package:bizeozel/views/AuthenticationPages/view/widgets.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

final TextEditingController _emailGiris = TextEditingController();
final TextEditingController _passwordGiris = TextEditingController();
final _formKey = GlobalKey<FormState>();
final LoginPageServices _login = LoginPageServices();
Widget loginPage(BuildContext context, bool run, onTap) {
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
                      _login.emailValidator;
                    }, Icons.alternate_email),
                    inputBoxAuth(_passwordGiris, context, 'Parola', TextInputType.visiblePassword, () {
                      _login.passwordValidator;
                    }, Icons.lock),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                        },
                        child: _buildForgotPasswordBtn(context))
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
              registerButton(context, _formKey, () {
                _login.signIn(context, _emailGiris.text.trim(), _passwordGiris.text);
              }, 'Giriş Yap!', 'null'),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            onTap();
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

Widget _buildForgotPasswordBtn(
  BuildContext context,
) {
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
