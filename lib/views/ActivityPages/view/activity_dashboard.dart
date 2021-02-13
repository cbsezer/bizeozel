import 'package:bizeozel/views/ActivityPages/view/activity_details.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AcitivityDashboard extends StatefulWidget {
  @override
  _AcitivityDashboardState createState() => _AcitivityDashboardState();
}

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                context.emptySizedWidthBoxLow3x,
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/icons/location.png',
                              height: context.height * 0.06,
                              width: context.height * 0.06,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                      context.emptySizedHeightBoxLow3x,
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
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AcitivityDetails()));
                    },
                    child: Column(
                      children: [
                        Container(
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
                                        '  Etkinlik',
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff822659)),
                                      ),
                                    ),
                                    Text(
                                      '  İstanbul',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff822659).withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: context.height * 0.128,
                                constraints: BoxConstraints(maxWidth: context.width * 0.78),
                                child: Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown',
                                  style: TextStyle(color: Color(0xff822659).withOpacity(0.7)),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        '307',
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
