import 'dart:io';

import 'package:bizeozel/core/components/colors/colors.dart';
import 'package:bizeozel/views/AuthenticationPages/services/SignUpServices.dart';
import 'package:bizeozel/views/AuthenticationPages/view/clipper.dart';
import 'package:bizeozel/views/AuthenticationPages/view/widgets.dart';
import 'package:bizeozel/views/bottom-navbar/navigation_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';

class SignUp extends StatefulWidget {
  final Function onTap;
  SignUp(this.onTap);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailKayit = TextEditingController();
  final TextEditingController _passwordKayit = TextEditingController();
  final TextEditingController _passwordKayitAgain = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final _formKey2 = GlobalKey<FormState>();
  final SignUpService _services = SignUpService();
  File _image;
  final picker = ImagePicker();
  var imageUrl;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    var fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = FirebaseStorage.instance.ref().child('Users').child('user_photo_' + fileName + '.jpg');
    var uploadTask = reference.putFile(_image);
    var storageTaskSnapshot = await uploadTask.onComplete;
    imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.onTap();
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
                    InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: context.height * 0.1,
                              width: context.height * 0.1,
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorPallette.color4, width: 1.5),
                                  borderRadius: context.highBorderRadius),
                              child: _image == null
                                  ? Icon(FontAwesomeIcons.plus, color: ColorPallette.color4)
                                  : ClipRRect(
                                      borderRadius: context.highBorderRadius,
                                      child: Image.file(_image, height: 70, fit: BoxFit.cover))),
                        ],
                      ),
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      child: registerButton(context, _formKey2, () {
                        _services.signUp(context, _emailKayit.text.trim(), _passwordKayit.text, imageUrl,
                            _passwordKayitAgain.text, _fullname.text);
                      }, 'Kayıt Ol!', imageUrl),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
