import 'package:bizeozel/core/components/widgets/widgets.dart';
import 'package:bizeozel/views/ActivityPages/view-model/activity_view_model.dart';
import 'package:bizeozel/views/AuthenticationPages/services/authentication.dart';
import 'package:bizeozel/views/AuthenticationPages/services/get_user_service.dart';
import 'package:bizeozel/views/WorkOffersPages/services/get_work_offers_service.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

Post post = Post();

class _MainDashboardState extends State<MainDashboard> {
  final Authentication _authentication = Authentication();

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
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        height: context.height * 0.5,
                      ),
                      customAppBarArea(context, snapshot),
                      customAppBarBehindCircle(context, -0.040, -50.0),
                      customAppBarBehindCircle(context, 0.02, 70.0),
                      FutureBuilder(
                        future: post.getAllPost(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data;
                            return Positioned(
                              bottom: -context.height * 0.001,
                              child: Container(
                                height: context.height * 0.22,
                                width: context.width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      context.emptySizedWidthBoxHigh,
                                      context.emptySizedWidthBoxLow3x,
                                      Container(
                                        width: context.width * 0.65,
                                        height: context.height * 0.22,
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(blurRadius: 5, color: Colors.grey.withOpacity(0.7)),
                                        ], color: Color(0xfff8a1d1), borderRadius: context.normalBorderRadius),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: context.paddingLow,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    '  ' + data.first.title,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color(0xff822659)),
                                                  ),
                                                  Image.asset(
                                                    'assets/icons/placeholder.png',
                                                    height: 40,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              constraints: BoxConstraints(maxWidth: context.width * 0.50),
                                              child: Text(
                                                data.first.description.toString(),
                                                style: TextStyle(color: Color(0xff822659).withOpacity(0.7)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      FutureBuilder(
                                        future: getWorkOffers(),
                                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return Container(
                                              width: context.width * 0.65,
                                              height: context.height * 0.22,
                                              decoration: BoxDecoration(boxShadow: [
                                                BoxShadow(blurRadius: 5, color: Colors.grey.withOpacity(0.7)),
                                              ], color: Color(0xfff8a1d1), borderRadius: context.normalBorderRadius),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: context.paddingLow,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '  ' + snapshot.data.documents[0]['CityName'].toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color(0xff822659)),
                                                        ),
                                                        Image.asset(
                                                          'assets/icons/new.png',
                                                          height: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    constraints: BoxConstraints(maxWidth: context.width * 0.5),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'İş Tanımı: ',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Color(0xff822659).withOpacity(0.7)),
                                                            ),
                                                            Text(
                                                              snapshot.data.documents[0]['WorkName'].toString(),
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Color(0xff822659).withOpacity(0.7)),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Lokasyon: ',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Color(0xff822659).withOpacity(0.7)),
                                                            ),
                                                            Text(
                                                              snapshot.data.documents[0]['CityName'],
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Color(0xff822659).withOpacity(0.7)),
                                                            ),
                                                          ],
                                                        ),
                                                        context.emptySizedHeightBoxLow,
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Image.asset(
                                                              'assets/icons/calendar.png',
                                                              height: 25,
                                                            ),
                                                            context.emptySizedWidthBoxLow,
                                                            Text(
                                                              snapshot.data.documents[0]['PublishDate'],
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Color(0xff822659).withOpacity(0.7)),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return loadingAnimation();
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: context.width * 0.65,
                                        height: context.height * 0.22,
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(blurRadius: 5, color: Colors.grey.withOpacity(0.7)),
                                        ], color: Color(0xfff8a1d1), borderRadius: context.normalBorderRadius),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: context.paddingLow,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    '  ' + data[1].title,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color(0xff822659)),
                                                  ),
                                                  Image.asset(
                                                    'assets/icons/placeholder.png',
                                                    height: 40,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              constraints: BoxConstraints(maxWidth: context.width * 0.50),
                                              child: Text(
                                                data[1].description.toString(),
                                                style: TextStyle(color: Color(0xff822659).withOpacity(0.7)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      context.emptySizedWidthBoxLow
                                    ],
                                  ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.emptySizedHeightBoxLow,
                      appBarHeader(context, 'Popüler Etkinlikler', 24.0, Colors.pink),
                      context.emptySizedHeightBoxLow,
                      Padding(
                        padding: context.horizontalPaddingMedium,
                        child: Container(
                          width: 350,
                          height: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder(
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
                  ),
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

  Container customAppBarArea(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      width: context.width,
      height: context.height * 0.4,
      decoration:
          BoxDecoration(color: Color(0xffb34180), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55))),
      child: appBarContent(context, snapshot),
    );
  }

  Column appBarContent(BuildContext context, AsyncSnapshot snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.emptySizedHeightBoxNormal,
        userPicArea(context, snapshot),
        appBarHeader(context, 'Merhaba, ${snapshot.data.fullname}', 18.0, Colors.white.withOpacity(0.7)),
        context.emptySizedHeightBoxLow,
        appBarHeader(context, 'BizeÖzel Dünyasına Hoş Geldin!', 24.0, Colors.white),
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
          Container(
            width: context.width * 0.83,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Padding(
                  padding: context.horizontalPaddingLow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        activityData[index].title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff822659)),
                      ),
                      Image.asset(
                        'assets/icons/placeholder.png',
                        height: 40,
                      ),
                    ],
                  ),
                ),
                context.emptySizedHeightBoxLow,
                Container(
                  constraints: BoxConstraints(maxWidth: context.width * 0.78),
                  child: Text(
                    activityData[index].description,
                    style: TextStyle(color: Color(0xff822659).withOpacity(0.8)),
                  ),
                ),
                context.emptySizedHeightBoxLow3x,
                Container(
                  width: context.width,
                  height: 0.5,
                  color: Colors.pink,
                ),
              ],
            ),
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
