import 'package:bizeozel/core/components/colors/colors.dart';
import 'package:bizeozel/core/components/helpers/helpers.dart';
import 'package:bizeozel/core/components/widgets/widgets.dart';
import 'package:bizeozel/views/ActivityPages/services/activity_services.dart';
import 'package:bizeozel/views/ActivityPages/view/activity_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class _AcitivityDetailsState extends State<AcitivityDetails> {
  File _imageFile;
  final TextEditingController _content = TextEditingController();
  var user = FirebaseAuth.instance.currentUser;
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                customAppBarArea(
                  context,
                  customAppBarBody(context, null, 'join.png', 'BizeOzel Events',
                      null, 0.06, true),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: context.height * 0.18,
                    left: context.height * 0.04,
                  ),
                  child: Screenshot(
                    controller: screenshotController,
                    child: cardBody(context),
                  ),
                ),
              ],
            ),
            commentsAndPostCommentArea(context),
          ],
        ),
      ),
    );
  }

  Column commentsAndPostCommentArea(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.emptySizedHeightBoxLow,
        Row(
          children: [
            context.emptySizedWidthBoxHigh,
            Container(
              width: context.width * 0.85,
              child: inputBox(context, 'Share Comment...', 1, () {
                setState(() {
                  saveComments(
                      widget.data.shareId, user.uid, _content, widget.data);
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
              'Comments',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorPallette.color4),
            ),
          ],
        ),
        commentBodyArea(context)
      ],
    );
  }

  Padding commentBodyArea(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingMedium,
      child: FutureBuilder(
        future: getAllComments(widget.data.shareId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return listViewForComment(snapshot);
          } else {
            return loadingAnimation();
          }
        },
      ),
    );
  }

  ListView listViewForComment(AsyncSnapshot snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey,
        thickness: 0.5,
      ),
      itemCount: widget.data.commentCount,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        var comData = snapshot.data[index];
        return Container(
          width: context.width * 0.9,
          height: 90,
          child: gettingComment(comData),
        );
      },
    );
  }

  FutureBuilder<DocumentSnapshot> gettingComment(comData) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('Users')
          .doc(comData['commentPublisher'])
          .get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var userData = snapshot.data;
          return comment(context, userData, comData);
        } else {
          return loadingAnimation();
        }
      },
    );
  }

  Row comment(BuildContext context, userData, comData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.emptySizedWidthBoxLow,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            commenterPic(context, userData),
          ],
        ),
        Padding(
          padding: context.verticalPaddingLow,
          child: commentArea(context, userData, comData),
        ),
      ],
    );
  }

  ClipRRect commenterPic(BuildContext context, userData) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.height * 0.0325),
      child: Image.network(
        userData['imgUrl'].toString(),
        height: context.height * 0.065,
        width: context.height * 0.065,
        fit: BoxFit.cover,
      ),
    );
  }

  Column commentArea(BuildContext context, userData, comData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.emptySizedHeightBoxLow,
        commentHeaderArea(context, userData, comData),
        SizedBox(
          height: 3,
        ),
        contentComment(context, comData),
      ],
    );
  }

  Container cardBody(BuildContext context) {
    return Container(
      width: context.width * 0.91,
      height: context.height * 0.45,
      child: Container(
        height: context.height * 0.22,
        decoration: BoxDecoration(
            color: ColorPallette.color3,
            borderRadius: context.normalBorderRadius),
        child: Column(
          children: [
            cardHeaderArea(context),
            context.emptySizedHeightBoxLow3x,
            cardDetailBodyArea(context),
            cardFooterArea()
          ],
        ),
      ),
    );
  }

  Widget cardFooterArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () async {
            await activityLikes(widget.data, user.uid);
            setState(() {});
          },
          child: cardFooterLikeArea(),
        ),
        cardFooterCommentArea(),
        cardFooterShare(),
      ],
    );
  }

  Row cardFooterLikeArea() {
    return Row(
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
          style: TextStyle(color: ColorPallette.color4),
        )
      ],
    );
  }

  Row cardFooterCommentArea() {
    return Row(
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
          style: TextStyle(color: ColorPallette.color4),
        )
      ],
    );
  }

  Widget cardFooterShare() {
    return GestureDetector(
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
              'Share',
              style: TextStyle(color: ColorPallette.color4),
            )
          ],
        ),
      ),
    );
  }

  Padding cardHeaderArea(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: postCardHeaderRow(
        context,
        widget.data.title,
        widget.data.location,
      ),
    );
  }

  Column cardDetailBodyArea(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: context.height * 0.32,
          constraints: BoxConstraints(maxWidth: context.width * 0.78),
          child: cardDetailBody(context),
        ),
      ],
    );
  }

  Column cardDetailBody(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.data.description,
          style: TextStyle(color: ColorPallette.color4.withOpacity(0.7)),
        ),
        context.emptySizedHeightBoxLow,
        Container(
          width: context.width,
          height: 0.5,
          color: ColorPallette.color4.withOpacity(0.5),
        ),
        context.emptySizedHeightBoxLow3x,
        cardDetails(context)
      ],
    );
  }

  Row cardDetails(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        cardDetailInfo(context),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ActivityImage(widget.data.imgUrl)));
          },
          child: cardDetailImage(context),
        )
      ],
    );
  }

  ClipRRect cardDetailImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: widget.data.imgUrl != null
          ? Image.network(
              widget.data.imgUrl,
              height: context.height * 0.15,
              width: context.height * 0.2,
            )
          : SizedBox(),
    );
  }

  Column cardDetailInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cardDetailDate(context),
        context.emptySizedHeightBoxLow,
        cardDetailTime(context),
      ],
    );
  }

  Row cardDetailTime(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/clock.png',
          height: 30,
        ),
        context.emptySizedWidthBoxLow,
        Text(
          widget.data.activityDate.split(' ')[1],
          style: TextStyle(
              color: ColorPallette.color4, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Row cardDetailDate(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/calendar.png',
          height: 30,
        ),
        context.emptySizedWidthBoxLow,
        Text(
          widget.data.activityDate.split(' ')[0],
          style: TextStyle(
              color: ColorPallette.color4, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget postCardHeaderRow(BuildContext context, first, second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: context.width * 0.5,
          ),
          child: Text(
            '  ' + first.toString(),
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorPallette.color4),
          ),
        ),
        Text(
          second,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorPallette.color4.withOpacity(0.5)),
        ),
      ],
    );
  }

  Container commentHeaderArea(BuildContext context, userData, comData) {
    return Container(
      width: context.width * 0.65,
      child: commentHeader(userData, comData),
    );
  }

  Row commentHeader(userData, comData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '   ' + userData['fullname'].toString(),
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: ColorPallette.color4),
        ),
        Text(
          readTimestamp(comData['commentDate']),
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: ColorPallette.color4),
        ),
      ],
    );
  }

  Padding contentComment(BuildContext context, comData) {
    return Padding(
      padding: context.horizontalPaddingLow * 2,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: context.width * 0.6, maxHeight: 50),
        child: Text(
          comData['commentContent'],
          style: TextStyle(fontSize: 14, color: ColorPallette.color4),
        ),
      ),
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
    );
  }

  // ignore: always_declare_return_types
  _takeScreenshotandShare() async {
    _imageFile = null;
    await screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((File image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      var pngBytes = _imageFile.readAsBytesSync();
      var imgFile = File('$directory/screenshot.png');
      await imgFile.writeAsBytes(pngBytes);
      print('File Saved to Gallery');
      await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
    }).catchError((onError) {
      print(onError);
    });
  }
}
