import 'package:bizeozel/core/components/colors/colors.dart';
import 'package:bizeozel/core/components/widgets/widgets.dart';
import 'package:bizeozel/views/ActivityPages/view-model/activity_view_model.dart';
import 'package:bizeozel/views/AuthenticationPages/services/get_user_service.dart';
import 'package:bizeozel/views/WorkOffersPages/services/get_work_offers_service.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

Post post = Post();

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: context.height * 0.5,
                      ),
                      customAppBarArea(context, snapshot),
                      customAppBarBehindCircle(context, -0.040, -50.0),
                      customAppBarBehindCircle(context, 0.02, 70.0),
                      FutureBuilder(
                        future: post.getAllPost(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data;
                            return Positioned(
                              left: -context.height * 0.02,
                              bottom: -context.height * 0.001,
                              child: Container(
                                height: context.height * 0.22,
                                width: context.width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: horizontalCardsArea(context, data),
                                ),
                              ),
                            );
                          } else {
                            return loadingAnimation();
                          }
                        },
                      ),
                    ],
                  ),
                  context.emptySizedHeightBoxLow3x,
                  popularActivitiesHeader(context),
                  gettingPopularAct(),
                ],
              ),
            );
          } else {
            return loadingAnimation();
          }
        },
      ),
    );
  }

  Row horizontalCardsArea(BuildContext context, data) {
    return Row(
      children: [
        context.emptySizedWidthBoxHigh,
        context.emptySizedWidthBoxLow3x,
        horizontalActCard(context, data, 2),
        SizedBox(
          width: 20,
        ),
        FutureBuilder(
          future: getWorkOffers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return horizontalWorkCardArea(context, snapshot);
            } else {
              return loadingAnimation();
            }
          },
        ),
        SizedBox(
          width: 20,
        ),
        horizontalActCard(context, data, 1),
        context.emptySizedWidthBoxLow
      ],
    );
  }

  Container horizontalWorkCardArea(
      BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      width: context.width * 0.65,
      height: context.height * 0.21,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 2),
      ], color: ColorPallette.color3, borderRadius: context.normalBorderRadius),
      child: Column(
        children: [
          horizontalWorkCardHeader(context, snapshot),
          horizontalWorkCardBody(context, snapshot),
        ],
      ),
    );
  }

  Container horizontalWorkCardBody(
      BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(maxWidth: context.width * 0.56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Job: ',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ColorPallette.color4.withOpacity(0.7)),
              ),
              Text(
                snapshot.data.documents[0]['WorkName'].toString(),
                style: TextStyle(
                    fontSize: 17, color: ColorPallette.color4.withOpacity(0.7)),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Location: ',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ColorPallette.color4.withOpacity(0.7)),
              ),
              Text(
                snapshot.data.documents[0]['CityName'],
                style: TextStyle(
                    fontSize: 17, color: ColorPallette.color4.withOpacity(0.7)),
              ),
            ],
          ),
          context.emptySizedHeightBoxLow,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/calendar.png',
                height: context.height * 0.028,
              ),
              context.emptySizedWidthBoxLow,
              Text(
                snapshot.data.documents[0]['PublishDate'],
                style: TextStyle(
                    fontSize: 17, color: ColorPallette.color4.withOpacity(0.7)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding horizontalWorkCardHeader(
      BuildContext context, AsyncSnapshot snapshot) {
    return Padding(
      padding: context.paddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '  ' + snapshot.data.documents[0]['CityName'].toString(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorPallette.color4),
          ),
          Image.asset(
            'assets/icons/new.png',
            height: context.height * 0.04,
          ),
        ],
      ),
    );
  }

  Container horizontalActCard(BuildContext context, data, index) {
    return Container(
      width: context.width * 0.65,
      height: context.height * 0.21,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 2),
      ], color: ColorPallette.color2, borderRadius: context.normalBorderRadius),
      child: Column(
        children: [
          Padding(
            padding: context.paddingLow,
            child: popularActCardHeader(data, index),
          ),
          Container(
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints(maxWidth: context.width * 0.56),
            child: Text(
              data[index].description.toString(),
              style: TextStyle(
                  fontSize: context.height * 0.02,
                  color: ColorPallette.color4.withOpacity(0.7)),
            ),
          ),
        ],
      ),
    );
  }

  Row popularActCardHeader(data, index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '  ' + data[index].title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorPallette.color4),
        ),
        Image.asset(
          'assets/icons/placeholder.png',
          height: context.height * 0.04,
        ),
      ],
    );
  }

  FutureBuilder<List> gettingPopularAct() {
    return FutureBuilder(
      future: post.getAllPost(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var activityData = snapshot.data;
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: activityData.length < 3 ? activityData.length : 3,
            itemBuilder: (BuildContext context, int index) {
              return popularActivityCard(context, index, activityData);
            },
          );
        } else {
          return loadingAnimation();
        }
      },
    );
  }

  Column popularActivitiesHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.emptySizedHeightBoxLow,
        appBarHeader(context, 'Popular Activities', context.height * 0.025,
            ColorPallette.color4),
        context.emptySizedHeightBoxLow,
        Padding(
          padding: context.horizontalPaddingMedium,
          child: Container(
            width: context.height * 0.35,
            height: 0.5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Container customAppBarArea(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      width: context.width,
      height: context.height * 0.4,
      decoration: BoxDecoration(
          color: ColorPallette.color4,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55))),
      child: appBarContent(context, snapshot),
    );
  }

  Column appBarContent(BuildContext context, AsyncSnapshot snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.emptySizedHeightBoxNormal,
        userPicArea(context, snapshot),
        appBarHeader(context, 'Hello, ${snapshot.data.fullname}', 18.0,
            Colors.white.withOpacity(0.7)),
        context.emptySizedHeightBoxLow,
        appBarHeader(context, 'Welcome To BizeOzel World!', 24.0, Colors.white),
      ],
    );
  }

  Padding userPicArea(BuildContext context, AsyncSnapshot snapshot) {
    return Padding(
      padding: context.horizontalPaddingMedium,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              userPicBehindShadow(context),
              customAppBarUserPic(context, snapshot),
            ],
          )
        ],
      ),
    );
  }

  Container userPicBehindShadow(BuildContext context) {
    return Container(
      height: context.height * 0.075,
      width: context.height * 0.075,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.white,
          )
        ],
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(context.height * 0.1),
      ),
    );
  }

  ClipRRect customAppBarUserPic(BuildContext context, AsyncSnapshot snapshot) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.height * 0.08),
      child: Image.network(
        snapshot.data.imgUrl,
        height: context.height * 0.07,
        width: context.height * 0.07,
        fit: BoxFit.cover,
      ),
    );
  }

  Padding popularActivityCard(BuildContext context, index, activityData) {
    return Padding(
      padding: context.verticalPaddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          actCardBodyContent(context, activityData, index),
        ],
      ),
    );
  }

  Container actCardBodyContent(BuildContext context, activityData, index) {
    return Container(
      width: context.width * 0.83,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          actCardHeader(context, activityData, index),
          context.emptySizedHeightBoxLow,
          actCardDescription(context, activityData, index),
          context.emptySizedHeightBoxLow3x,
          Container(
            width: context.width,
            height: 0.5,
            color: ColorPallette.color4,
          ),
        ],
      ),
    );
  }

  Container actCardDescription(BuildContext context, activityData, index) {
    return Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(maxWidth: context.width * 0.78),
      child: Text(
        activityData[index].description,
        style: TextStyle(
            fontSize: context.height * 0.02,
            color: ColorPallette.color4.withOpacity(0.8)),
      ),
    );
  }

  Padding actCardHeader(BuildContext context, activityData, index) {
    return Padding(
      padding: context.horizontalPaddingLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            activityData[index].title,
            style: TextStyle(
                fontSize: context.height * 0.026,
                fontWeight: FontWeight.bold,
                color: ColorPallette.color4),
          ),
          Image.asset(
            'assets/icons/placeholder.png',
            height: context.height * 0.04,
          ),
        ],
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
}
