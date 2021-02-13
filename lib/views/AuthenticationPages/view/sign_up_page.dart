import 'package:bizeozel/views/AuthenticationPages/services/SignUpServices.dart';
import 'package:bizeozel/views/AuthenticationPages/services/loader.dart';
import 'package:bizeozel/views/AuthenticationPages/view/clipper.dart';
import 'package:bizeozel/views/AuthenticationPages/view/widgets.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

final TextEditingController _emailKayit = TextEditingController();
final TextEditingController _passwordKayit = TextEditingController();
final TextEditingController _passwordKayitAgain = TextEditingController();
final TextEditingController _fullname = TextEditingController();
final _formKey2 = GlobalKey<FormState>();
final SignUpService _services = SignUpService();

Widget signUpPage(BuildContext context, bool run, onTap) {
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
                  onTap();
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
                    child: registerButton(context, _formKey2, () {
                      _services.signUp(context, _emailKayit.text.trim(), _passwordKayit.text, _passwordKayitAgain.text,
                          _fullname.text);
                    }, 'Kayıt Ol!'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
