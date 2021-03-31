import 'dart:io';
import 'package:bizeozel/core/components/colors/colors.dart';
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
        children: [
          customAppBarArea(
            context,
            customAppBarBody(context, null, 'new.png', 'Create Event!',
                Colors.white, 0.05, true),
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
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 30,
                                spreadRadius: 10,
                                color: ColorPallette.color4)
                          ],
                          color: Colors.white),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            text('Event Name*:'),
                            inputBox(context, 'Event Name: ', 1,
                                controller.title, 13),
                            text('Event Location*:'),
                            inputBox(context, 'Event Location: ', 1,
                                controller.location, 15),
                            text('Date*:'),
                            SizedBox(height: context.height * 0.01),
                            datePickerContainer(context),
                            text('Description*:'),
                            inputBox(context, 'Description:', 4,
                                controller.description, 400),
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
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
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
              color: ColorPallette.color4,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Create',
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
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => true);
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
    var reference = FirebaseStorage.instance
        .ref()
        .child('Activities')
        .child('activity' + fileName + '.jpg');
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
    var db = Sharing(
        user.uid,
        shareName,
        DateTime.now(),
        controller.location.text,
        [],
        0,
        controller.date.text,
        imageUrl,
        controller.description.text,
        controller.title.text,
        0,
        [],
        0);

    var activityDetail =
        FirebaseFirestore.instance.collection('Activities').doc(shareName);
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
        Text('Add Photo: '),
        InkWell(
          onTap: () {
            getImage();
          },
          child: Row(
            children: [
              Padding(
                padding: context.paddingNormal,
                child: Container(
                    height: 60,
                    width: 50,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorPallette.color4, width: 1.5),
                        borderRadius: context.lowBorderRadius),
                    child: _image == null
                        ? Icon(FontAwesomeIcons.plus,
                            color: ColorPallette.color4)
                        : Image.file(_image, height: 60, fit: BoxFit.cover)),
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
      decoration: BoxDecoration(
          border: Border.all(color: ColorPallette.color4),
          borderRadius: BorderRadius.circular(10)),
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
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: ColorPallette.color4),
          ),
        ],
      ),
    );
  }

  Widget inputBox(BuildContext context, text, line, controller, length) {
    return Padding(
      padding: EdgeInsets.only(
          top: context.height * 0.01,
          left: context.height * 0.02,
          right: context.height * 0.02),
      child: TextFormField(
        maxLength: length,
        controller: controller,
        maxLines: line,
        cursorColor: Colors.black,
        autofocus: false,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 15.0, color: Colors.black),
        decoration: InputDecoration(
          hintText: text,
          filled: true,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorPallette.color4),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorPallette.color4),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
