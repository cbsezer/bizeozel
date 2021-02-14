import 'dart:io';
import 'package:bizeozel/core/components/widgets/widgets.dart';
import 'package:bizeozel/views/ActivityPages/model/ActivityModel.dart';
import 'package:bizeozel/views/ActivityPages/model/TextFormField.dart';
import 'package:bizeozel/views/bottom-navbar/nav_bar_helper.dart';
import 'package:bizeozel/views/bottom-navbar/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';

class ActivityShare extends StatefulWidget {
  @override
  _ActivityShareState createState() => _ActivityShareState();
}

class _ActivityShareState extends State<ActivityShare> {
  Controller controller = Controller();
  bool firstpress = true;
  var imageUrl;
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          customAppBarArea(
            context,
            customAppBarBody(context, null, 'new.png', 'Etkinlik Oluşturun!', Colors.white, 0.05, true),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.height * 0.04),
            child: Container(
              padding: EdgeInsets.only(top: context.height * 0.16),
              height: context.height * 0.9,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: context.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
                          boxShadow: [BoxShadow(blurRadius: 30, spreadRadius: 10, color: Color(0xff822659))],
                          color: Colors.white),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            text('Etkinlik Adını Yazınız*:'),
                            inputBox(context, 'Etkinlik Adı: ', 1, controller.title),
                            text('Yeri Yazınız*:'),
                            inputBox(context, 'Etkinlik Yeri: ', 1, controller.location),
                            text('Tarih Giriniz*:'),
                            SizedBox(height: context.height * 0.01),
                            datePickerContainer(context),
                            text('Açıklama Yazınız*:'),
                            inputBox(context, 'Açıklama:', 6, controller.description),
                            addPhoto(context),
                            sendPost(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget sendPost(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
          onTap: () async {
            if (firstpress) {
              firstpress = false;
              await postShare(_image);
              setState(() {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => Container(
                            width: context.width,
                            height: context.height,
                            color: Colors.white,
                            child: (loadingAnimation()))),
                    (Route<dynamic> route) => true);
                delay();
              });
            }
          },
          child: Container(
            height: context.height * 0.07,
            width: context.width * 0.6,
            decoration: BoxDecoration(
              color: Color(0xffb34180),
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Oluştur',
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
                context.emptySizedWidthBoxHigh
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future delay() async {
    await Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (Route<dynamic> route) => true);
      bottomNavBarSelectedIndex = 1;
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<dynamic> postImage(imageFile) async {
    var fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = FirebaseStorage.instance.ref().child('Activities').child('activity' + fileName + '.jpg');
    var uploadTask = reference.putFile(imageFile);
    var storageTaskSnapshot = await uploadTask.onComplete;
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  Future postShare(imageFile) async {
    var user = FirebaseAuth.instance.currentUser;
    var shareName = DateTime.now().microsecondsSinceEpoch.toString();
    if (imageFile != null) {
      await postImage(imageFile).then((downloadUrl) {
        imageUrl = downloadUrl.toString();
      });
    }
    var db = Sharing(user.uid, shareName, DateTime.now(), controller.location.text, [], 0, controller.date.text,
        imageUrl, controller.description.text, controller.title.text, 0, [], 0);

    var activityDetail = FirebaseFirestore.instance.collection('Activities').doc(shareName);
    await activityDetail.set(db.toMap());
    await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
      'activities': FieldValue.arrayUnion([shareName]),
    });
    await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
      'activities': FieldValue.arrayUnion([shareName]),
    });
  }

  Widget addPhoto(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Fotoğraf Ekleyin: '),
        InkWell(
          onTap: () {
            getImage();
          },
          child: Row(
            children: [
              Padding(
                padding: context.paddingNormal,
                child: Container(
                    height: 70,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff822659), width: 1.5),
                        borderRadius: context.lowBorderRadius),
                    child: _image == null
                        ? Icon(FontAwesomeIcons.plus, color: Color(0xffb34180))
                        : Image.file(_image, height: 70, fit: BoxFit.cover)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget datePickerContainer(BuildContext context) {
    return Container(
      width: context.width * 0.82,
      padding: context.horizontalPaddingLow,
      decoration: BoxDecoration(border: Border.all(color: Color(0xffb34180)), borderRadius: BorderRadius.circular(10)),
      child: DateTimePicker(
        type: DateTimePickerType.dateTimeSeparate,
        dateMask: 'd MMM, yyyy',
        controller: controller.date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        showCursor: false,
        decoration: InputDecoration(border: InputBorder.none),
        dateHintText: 'Date',
        timeHintText: 'Hour',
        onChanged: (val) => print(val),
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) => print(val),
      ),
    );
  }

  Widget text(text) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff822659)),
          ),
        ],
      ),
    );
  }

  Widget inputBox(BuildContext context, text, line, controller) {
    return Padding(
      padding: EdgeInsets.only(top: context.height * 0.01, left: context.height * 0.02, right: context.height * 0.02),
      child: TextFormField(
        controller: controller,
        maxLines: line,
        cursorColor: Colors.black,
        autofocus: false,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 15.0, color: Colors.black),
        decoration: InputDecoration(
          hintText: text,
          filled: true,
          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffb34180)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffb34180)),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
