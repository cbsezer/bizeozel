import 'package:bizeozel/views/ActivityPages/view/share_activity.dart';
import 'package:bizeozel/views/ActivityPages/view/activity_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

class WorkOffersDashboard extends StatefulWidget {
  @override
  _WorkOffersDashboardState createState() => _WorkOffersDashboardState();
}

class _WorkOffersDashboardState extends State<WorkOffersDashboard> {
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
                            Image.asset(
                              'assets/icons/searching.png',
                              height: 35,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      context.emptySizedHeightBoxLow,
                      context.emptySizedHeightBoxLow,
                      appBarHeader(context, 'BizeÖzel İlanları Kaçırmayın!', 24.0, Colors.white),
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
                          height: context.height * 0.17,
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
                                        '  Flutter Developer',
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
                                alignment: Alignment.topLeft,
                                height: context.height * 0.065,
                                constraints: BoxConstraints(maxWidth: context.width * 0.78),
                                child: Text(
                                  'Lorem Ipsum is simply ',
                                  style: TextStyle(fontSize: 17, color: Color(0xff822659).withOpacity(0.7)),
                                ),
                              ),
                              Padding(
                                padding: context.horizontalPaddingNormal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/schedule.png',
                                          height: 30,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Yayınlanma Tarihi',
                                              style: TextStyle(color: Color(0xff822659)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 3),
                                              child: Container(
                                                width: 75,
                                                height: 0.5,
                                                color: Color(0xff822659),
                                              ),
                                            ),
                                            Text(
                                              '27/02/2021',
                                              style: TextStyle(color: Color(0xff822659)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Detaya Git',
                                          style: TextStyle(fontSize: 14, color: Color(0xff822659)),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xff822659),
                                          size: 30,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
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
