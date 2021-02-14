import 'package:bizeozel/core/components/helpers/globalUserData.dart';
import 'package:bizeozel/core/components/helpers/helpers.dart';
import 'package:bizeozel/core/components/widgets/widgets.dart';
import 'package:bizeozel/views/ActivityPages/services/activity_services.dart';
import 'package:bizeozel/views/ActivityPages/view/activity_dashboard.dart';
import 'package:bizeozel/views/ActivityPages/view/activity_image.dart';
import 'package:bizeozel/views/AuthenticationPages/models/UserModel.dart';
import 'package:bizeozel/views/AuthenticationPages/services/get_user_service.dart';
import 'package:bizeozel/views/bottom-navbar/nav_bar_helper.dart';
import 'package:bizeozel/views/bottom-navbar/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/ActivityModel.dart';
import 'package:kartal/kartal.dart';
import 'dart:io';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class AcitivityDetails extends StatefulWidget {
  Sharing data;

  AcitivityDetails(this.data);
  @override
  _AcitivityDetailsState createState() => _AcitivityDetailsState();
}

TextEditingController _content = TextEditingController();

class _AcitivityDetailsState extends State<AcitivityDetails> {
  File _imageFile;

  var user = FirebaseAuth.instance.currentUser;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  height: context.height * 0.4,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        width: context.width,
                        height: context.height * 0.4,
                        decoration: BoxDecoration(
                            color: Color(0xffb34180), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            context.emptySizedHeightBoxNormal,
                            Padding(
                              padding: context.horizontalPaddingLow,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      context.emptySizedWidthBoxLow3x,
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                          bottomNavBarSelectedIndex = 1;
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await activityParticipants(widget.data, user.uid);
                                      setState(() {});
                                    },
                                    child: Image.asset(
                                      'assets/icons/join.png',
                                      height: context.height * 0.073,
                                      width: context.height * 0.073,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            appBarHeader(context, 'BizeÖzel Etkinlik', 24.0, Colors.white),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -context.height * 0.04,
                        right: -50,
                        child: Container(
                          width: context.height * 0.22,
                          height: context.height * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(context.height * 0.1)),
                        ),
                      ),
                      Positioned(
                        bottom: -context.height * 0.1,
                        right: 70,
                        child: Container(
                          width: context.height * 0.22,
                          height: context.height * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(context.height * 0.1)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: context.height * 0.18,
                    left: context.height * 0.04,
                  ),
                  child: Screenshot(
                    controller: screenshotController,
                    child: Container(
                      width: context.width * 0.91,
                      height: context.height * 0.45,
                      child: Container(
                        height: context.height * 0.22,
                        decoration: BoxDecoration(color: Color(0xfff8a1d1), borderRadius: context.normalBorderRadius),
                        child: Column(
                          children: [
                            Padding(
                              padding: context.paddingLow,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: context.width * 0.5,
                                    ),
                                    child: Text(
                                      '  ' + widget.data.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff822659)),
                                    ),
                                  ),
                                  Text(
                                    '  ' + widget.data.location,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff822659).withOpacity(0.5)),
                                  ),
                                ],
                              ),
                            ),
                            context.emptySizedHeightBoxLow3x,
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  height: context.height * 0.32,
                                  constraints: BoxConstraints(maxWidth: context.width * 0.78),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.data.description,
                                        style: TextStyle(color: Color(0xff822659).withOpacity(0.7)),
                                      ),
                                      context.emptySizedHeightBoxLow,
                                      Container(
                                        width: context.width,
                                        height: 0.5,
                                        color: Colors.pink.withOpacity(0.5),
                                      ),
                                      context.emptySizedHeightBoxLow3x,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/icons/calendar.png',
                                                    height: 30,
                                                  ),
                                                  context.emptySizedWidthBoxLow,
                                                  Text(
                                                    widget.data.activityDate.split(' ')[0],
                                                    style: TextStyle(
                                                        color: Color(0xff822659), fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              context.emptySizedHeightBoxLow,
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/icons/clock.png',
                                                    height: 30,
                                                  ),
                                                  context.emptySizedWidthBoxLow,
                                                  Text(
                                                    widget.data.activityDate.split(' ')[1],
                                                    style: TextStyle(
                                                        color: Color(0xff822659), fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => ActivityImage(widget.data.imgUrl)));
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: widget.data.imgUrl != null
                                                  ? Image.network(
                                                      widget.data.imgUrl,
                                                      height: context.height * 0.15,
                                                    )
                                                  : SizedBox(),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await activityLikes(widget.data, user.uid);
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/thumbs-up.png',
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        widget.data.likeCount.toString(),
                                        style: TextStyle(color: Color(0xff822659)),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/comment.png',
                                      height: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.data.commentCount.toString(),
                                      style: TextStyle(color: Color(0xff822659)),
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await _takeScreenshotandShare();
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/sharing.png',
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          'Paylaş',
                                          style: TextStyle(color: Color(0xff822659)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.emptySizedHeightBoxLow,
                Row(
                  children: [
                    context.emptySizedWidthBoxHigh,
                    Container(
                      width: context.width * 0.85,
                      child: inputBox(context, 'Yorum Yazın...', 1, () {
                        setState(() {
                          saveComments(widget.data.shareId, widget.data.publisher, _content, widget.data);
                        });
                      }),
                    )
                  ],
                ),
                context.emptySizedHeightBoxLow,
                Row(
                  children: [
                    context.emptySizedWidthBoxHigh,
                    Text(
                      'Yorumlar',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff822659)),
                    ),
                  ],
                ),
                Padding(
                  padding: context.horizontalPaddingMedium,
                  child: FutureBuilder(
                    future: getAllComments(widget.data.shareId),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          itemCount: widget.data.commentCount,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: context.width * 0.9,
                              height: 90,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  context.emptySizedWidthBoxLow,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(context.height * 0.0325),
                                        child: Image.network(
                                          userImgUrl,
                                          height: context.height * 0.065,
                                          width: context.height * 0.065,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: context.verticalPaddingLow,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        context.emptySizedHeightBoxLow,
                                        Container(
                                          width: context.width * 0.65,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '   ' + fullname,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff822659)),
                                              ),
                                              Text(
                                                readTimestamp(snapshot.data[index]['commentDate']),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff822659)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Padding(
                                          padding: context.horizontalPaddingLow * 2,
                                          child: Container(
                                            constraints: BoxConstraints(maxWidth: context.width * 0.6, maxHeight: 50),
                                            child: Text(
                                              snapshot.data[index]['commentContent'],
                                              style: TextStyle(fontSize: 14, color: Color(0xff822659)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return loadingAnimation();
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
          onPressed: () async {
           
          },
          child: Icon(Icons.share),
        ), */
    );
  }

  Widget inputBox(BuildContext context, text, line, onTap) {
    return TextFormField(
      controller: _content,
      maxLines: line,
      cursorColor: Colors.black,
      autofocus: false,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15.0, color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            onTap();
            _content.text = '';
          },
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Image.asset(
              'assets/icons/comment.png',
              height: 10,
            ),
          ),
        ),
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
    );
  }

  Widget appBarHeader(BuildContext context, text, size, color) {
    return Padding(
      padding: context.horizontalPaddingMedium,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: size,
        ),
      ),
    );
  }

  _takeScreenshotandShare() async {
    _imageFile = null;
    await screenshotController.capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0).then((File image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      var pngBytes = _imageFile.readAsBytesSync();
      var imgFile = File('$directory/screenshot.png');
      await imgFile.writeAsBytes(pngBytes);
      print('File Saved to Gallery');
      await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
//await _launchURL('https://twitter.com/');
    }).catchError((onError) {
      print(onError);
    });
  }
  /* _launchURL(url) async {

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
} */
}
