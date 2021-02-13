import 'package:bizeozel/views/ActivityPages/view-model/activity_view_model.dart';
import 'package:bizeozel/views/ActivityPages/view/share_activity.dart';
import 'package:bizeozel/views/ActivityPages/view/activity_details.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AcitivityDashboard extends StatefulWidget {
  @override
  _AcitivityDashboardState createState() => _AcitivityDashboardState();
}

Post post = Post();

class _AcitivityDashboardState extends State<AcitivityDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityShare()));
                              },
                              child: Image.asset(
                                'assets/icons/location.png',
                                height: context.height * 0.06,
                                width: context.height * 0.06,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      context.emptySizedHeightBoxLow,
                      context.emptySizedHeightBoxLow,
                      appBarHeader(context, 'BizeÖzel Etkinlikleri Kaçırmayın!', 24.0, Colors.white),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -context.height * 0.04,
                  right: -50,
                  child: Container(
                    width: context.height * 0.22,
                    height: context.height * 0.2,
                    decoration:
                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(context.height * 0.1)),
                  ),
                ),
                Positioned(
                  bottom: -context.height * 0.1,
                  right: 70,
                  child: Container(
                    width: context.height * 0.22,
                    height: context.height * 0.2,
                    decoration:
                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(context.height * 0.1)),
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
            child: Container(
              width: context.width * 0.9,
              height: context.height,
              child: FutureBuilder(
                future: post.getAllPost(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data[index].runtimeType);
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AcitivityDetails(snapshot.data[index])));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: context.height * 0.22,
                                decoration:
                                    BoxDecoration(color: Color(0xfff8a1d1), borderRadius: context.normalBorderRadius),
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
                                              '  ' + snapshot.data[index].title.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff822659)),
                                            ),
                                          ),
                                          Text(
                                            '  ' + snapshot.data[index].location,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff822659).withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: context.height * 0.11,
                                      constraints: BoxConstraints(maxWidth: context.width * 0.78),
                                      child: Text(
                                        snapshot.data[index].description.toString(),
                                        style: TextStyle(color: Color(0xff822659).withOpacity(0.7)),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/thumbs-up.png',
                                              height: 30,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              snapshot.data[index].likeCount.toString(),
                                              style: TextStyle(color: Color(0xff822659)),
                                            )
                                          ],
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
                                              '307',
                                              style: TextStyle(color: Color(0xff822659)),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/pedestrian.png',
                                              height: 45,
                                            ),
                                            Text(
                                              '307',
                                              style: TextStyle(color: Color(0xff822659)),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              context.emptySizedHeightBoxLow
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
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
