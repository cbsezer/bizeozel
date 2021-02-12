import 'package:bizeozel/components/widgets/getcolorfromhex.dart';
import 'package:bizeozel/view-model/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

TextEditingController _emailVerification = TextEditingController();
Authentication _authentication = Authentication();
final formKey = GlobalKey<FormState>();

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    //  var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Şifremi Unuttum!',
            style: TextStyle(color: Colors.white),
          ),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: context.height,
            width: context.width,
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    _linearGradientColor(context),
                    Container(
                      height: context.dynamicHeight(0.5),
                      width: context.width,
                    )
                  ],
                ),
                Positioned(
                  top: context.height < 540 ? 180 : 190,
                  child: Container(
                    alignment: Alignment.center,
                    width: context.dynamicWidth(0.9),
                    height: context.height < 540
                        ? context.height * 0.44
                        : context.height * 0.35,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              blurRadius: 5,
                              offset: Offset(0, 1))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 25),
                      child: Column(
                        children: [
                          Text(
                            'Şifrenizi yenilemek için e-posta adresinize bir link gelecektir. Gelen linke tıklayıp yeni şifrenizi belirleyebilirsiniz.',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black.withOpacity(0.6),
                                fontSize: context.height < 540 ? 13 : 15),
                          ),
                          SizedBox(height: context.height < 540 ? 10 : 20),
                          _inputForm(),
                          SizedBox(
                            height: context.height < 540 ? 10 : 20,
                          ),
                          InkWell(
                            onTap: () async {
                              await _authentication.resetPassword(
                                  _emailVerification.text.trim());
                              await _showdialog(context);
                            },
                            child: _gradientButton(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  child: Image.asset(
                    'assets/images/locked.png',
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputForm() {
    return Form(
      key: formKey,
      child: TextField(
        controller: _emailVerification,
        style: TextStyle(fontSize: 15.0, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'E-posta',
          contentPadding:
              const EdgeInsets.only(left: 10.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.7)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.7)),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Future _showdialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              // title: Text(""),
              content: Text(
                'Şifre sıfırlama talebiniz mail adresinize gönderildi.',
                style: TextStyle(fontSize: 18),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Tamam',
                    style: TextStyle(color: Colors.red.withOpacity(0.7)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  Widget _gradientButton(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [getColorFromHex('822659'), getColorFromHex('f8a1d1')]),
            borderRadius: BorderRadius.circular(5)),
        child: Text('Şifremi Yenile',
            style: TextStyle(
              color: Colors.white,
              fontSize: context.height < 540 ? 15 : 17,
            )));
  }

  Widget _linearGradientColor(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.4),
      width: context.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [getColorFromHex('822659'), getColorFromHex('f8a1d1')])),
    );
  }
}
