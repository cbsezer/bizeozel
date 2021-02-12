import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
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

  final TextEditingController _location = TextEditingController();
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: context.height * 0.4,
            width: context.width,
            decoration: BoxDecoration(borderRadius: context.highBorderRadius, color: Color(0xffb34180)),
            child: Padding(
              padding: EdgeInsets.only(bottom: context.height * 0.1, left: context.width * 0.065),
              child: Text('Etkinlik Oluştur', style: TextStyle(color: Colors.white, fontSize: context.height * 0.033)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: context.height * 0.2),
            height: context.height * 0.95,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: context.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
                      boxShadow: [BoxShadow(blurRadius: 5, color: Color(0xffb34180))],
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //explanation
                          //photo
                          text('Etkinlik Adını Giriniz:'),
                          inputBox(context, 'Etkinlik Adı: ', 1),
                          text('Etkinlik Yerini Giriniz:'),
                          inputBox(context, 'Etkinlik Yeri: ', 1),
                          text('Etkinlik Tarihini Giriniz:'),
                          SizedBox(height: context.height * 0.01),
                          Container(
                            width: context.width * 0.82,
                            padding: context.horizontalPaddingLow,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffb34180)), borderRadius: BorderRadius.circular(10)),
                            child: DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'd MMM, yyyy',
                              initialValue: DateTime.now().toString(),
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
                          ),
                          text('Etkinlik Açıklaması Giriniz:'),
                          inputBox(context, 'Etkinlik Açıklaması:', 6),
                          Row(
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
                                        decoration:
                                            BoxDecoration(border: Border.all(), borderRadius: context.lowBorderRadius),
                                        child: _image == null
                                            ? Icon(FontAwesomeIcons.plus, color: Color(0xffb34180))
                                            : Image.file(_image, height: 70, fit: BoxFit.cover),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          context.emptySizedHeightBoxLow3x,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                borderRadius:
                                    BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
                                onTap: () {},
                                child: Container(
                                  height: context.height * 0.07,
                                  width: context.width * 0.6,
                                  decoration: BoxDecoration(
                                    color: Colors.pink[200],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget text(text) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(text),
        ],
      ),
    );
  }

  Widget inputBox(BuildContext context, text, line) {
    return Padding(
      padding: EdgeInsets.only(top: context.height * 0.01, left: context.height * 0.02, right: context.height * 0.02),
      child: TextFormField(
        onChanged: (value) {
          print(value.runtimeType);
        },
        controller: _location,
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
