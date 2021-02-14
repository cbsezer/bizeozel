import 'package:bizeozel/core/components/colors/colors.dart';
import 'package:bizeozel/core/components/widgets/widgets.dart';
import 'package:bizeozel/views/AuthenticationPages/services/get_user_service.dart';
import 'package:bizeozel/views/ProfilePages/services/profile_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

GetUser user = GetUser();

class _UserProfileState extends State<UserProfile> {
  bool isclicked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var userData = snapshot.data;
              return Stack(
                children: [
                  customAppBarArea(
                    context,
                    customAppBarBody(context, null, 'searching.png', 'Profil', Colors.white, 0.05, false),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: context.height * 0.12,
                      left: context.height * 0.036,
                    ),
                    child: Container(
                      width: context.width * 0.9,
                      child: profileContentBody(context, userData),
                    ),
                  ),
                ],
              );
            } else {
              return loadingAnimation();
            }
          },
        ),
      ),
    );
  }

  Column profileContentBody(BuildContext context, userData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.emptySizedHeightBoxNormal,
        userPicArea(context, userData),
        context.emptySizedHeightBoxHigh,
        appBarHeader(context, 'Etkinlikler', 24.0, ColorPallette.color4, false),
        listViewBody(userData),
      ],
    );
  }

  Row userPicArea(BuildContext context, userData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        userPicShadow(context, userData),
        context.emptySizedWidthBoxLow,
        userInfos(context, userData),
      ],
    );
  }

  Container userPicShadow(BuildContext context, userData) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: context.normalBorderRadius,
          boxShadow: [BoxShadow(blurRadius: 7, color: Colors.grey.withOpacity(0.7))]),
      child: userPic(context, userData),
    );
  }

  ClipRRect userPic(BuildContext context, userData) {
    return ClipRRect(
      borderRadius: context.normalBorderRadius,
      child: Image.network(
        userData.imgUrl,
        height: context.height * 0.16,
      ),
    );
  }

  Padding userInfos(BuildContext context, userData) {
    return Padding(
      padding: context.verticalPaddingLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userData.fullname,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            userData.email,
            style: TextStyle(fontSize: 17, color: Colors.white.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  ListView listViewBody(userData) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: userData.activities.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return FutureBuilder(
          future: user.getUserActivities(userData.activities[index]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: [
                  postCardBodyArea(context, snapshot, index, 0.2, postCardBodyContent(context, snapshot, index, data)),
                  context.emptySizedHeightBoxLow
                ],
              );
            } else {
              return loadingAnimation();
            }
          },
        );
      },
    );
  }

  Column postCardBodyContent(BuildContext context, AsyncSnapshot snapshot, int index, data) {
    return Column(
      children: [
        Padding(
          padding: context.paddingLow,
          child: postCardHeaderRow(context, snapshot, index, data.title, data.title),
        ),
        acitivityCardDescription(context, data),
        context.emptySizedHeightBoxLow,
        postCardBottomArea(context, snapshot)
      ],
    );
  }

  Padding postCardBottomArea(BuildContext context, AsyncSnapshot snapshot) {
    return Padding(
      padding: context.horizontalPaddingNormal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          postCardBottomRow(snapshot),
        ],
      ),
    );
  }

  Row postCardBottomRow(AsyncSnapshot snapshot) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        postCardBottomRowItem(snapshot, 30.0, 'schedule.png', snapshot.data.activityDate.toString().split(' ')[0]),
        postCardBottomRowItem(snapshot, 25.0, 'clock.png', snapshot.data.activityDate.toString().split(' ')[1]),
      ],
    );
  }

  Row postCardBottomRowItem(AsyncSnapshot snapshot, iconSize, iconName, data) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/$iconName',
          height: iconSize,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          data.toString(),
          style: TextStyle(color: ColorPallette.color4),
        )
      ],
    );
  }

  Container acitivityCardDescription(BuildContext context, data) {
    return Container(
      alignment: Alignment.topLeft,
      height: context.height * 0.055,
      constraints: BoxConstraints(
        maxWidth: context.width * 0.78,
      ),
      child: Text(
        data.description,
        maxLines: 2,
        style: TextStyle(fontSize: 17, color: ColorPallette.color4.withOpacity(0.7)),
      ),
    );
  }
}
