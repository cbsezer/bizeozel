import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                height: context.height * 0.5,
              ),
              Container(
                width: context.width,
                height: context.height * 0.4,
                decoration: BoxDecoration(
                    color: Color(0xffb34180), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(55))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.emptySizedHeightBoxNormal,
                    Padding(
                      padding: context.horizontalPaddingMedium,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            FontAwesomeIcons.bars,
                            color: Colors.white,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
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
                                    borderRadius: BorderRadius.circular(context.height * 0.1)),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(context.height * 0.08),
                                child: Image.network(
                                  'https://maheralayoubi.com/mohamad2/image/per4.jpeg',
                                  height: context.height * 0.07,
                                  width: context.height * 0.07,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    context.emptySizedHeightBoxLow3x,
                    appBarHeader(context, 'Merhaba, Veli', 18.0, Colors.white.withOpacity(0.7)),
                    context.emptySizedHeightBoxLow,
                    appBarHeader(context, 'BizeÖzel Dünyasına Hoş Geldin!', 24.0, Colors.white),
                  ],
                ),
              ),
              Positioned(
                bottom: context.height * 0.040,
                right: -50,
                child: Container(
                  width: context.height * 0.22,
                  height: context.height * 0.2,
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(context.height * 0.1)),
                ),
              ),
              Positioned(
                bottom: -context.height * 0.02,
                right: 70,
                child: Container(
                  width: context.height * 0.22,
                  height: context.height * 0.2,
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(context.height * 0.1)),
                ),
              ),
              Positioned(
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
                          decoration: BoxDecoration(color: Color(0xfff8a1d1), borderRadius: context.normalBorderRadius),
                          child: Column(
                            children: [
                              Padding(
                                padding: context.paddingLow,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '  Etkinlik',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff822659)),
                                    ),
                                    Image.asset(
                                      'assets/icons/placeholder.png',
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: context.width * 0.50),
                                child: Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown',
                                  style: TextStyle(color: Color(0xff822659).withOpacity(0.7)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: context.width * 0.65,
                          height: context.height * 0.22,
                          decoration: BoxDecoration(color: Color(0xfff8a1d1), borderRadius: context.normalBorderRadius),
                          child: Column(
                            children: [
                              Padding(
                                padding: context.paddingLow,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '  İş İlanı',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff822659)),
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
                                          'Flutter Dev..',
                                          style: TextStyle(fontSize: 17, color: Color(0xff822659).withOpacity(0.7)),
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
                                          'İstanbul',
                                          style: TextStyle(fontSize: 17, color: Color(0xff822659).withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'İstihdam Türü: ',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff822659).withOpacity(0.7)),
                                        ),
                                        Text(
                                          'Tam Zamanlı',
                                          style: TextStyle(fontSize: 17, color: Color(0xff822659).withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: context.width * 0.65,
                          height: context.height * 0.22,
                          decoration: BoxDecoration(color: Color(0xfff8a1d1), borderRadius: context.normalBorderRadius),
                          child: Column(
                            children: [
                              Padding(
                                padding: context.paddingLow,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '  Etkinlik',
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff822659)),
                                    ),
                                    Image.asset(
                                      'assets/icons/placeholder.png',
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: context.width * 0.50),
                                child: Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown',
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
              ),
            ],
          ),
          context.emptySizedHeightBoxLow3x,
          appBarHeader(context, 'Category', 24.0, Colors.pink),
          context.emptySizedHeightBoxLow,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              context.emptySizedWidthBoxLow,
              tabBarRowItem(context, Color(0xff822659)),
              context.emptySizedWidthBoxLow,
              tabBarRowItem(context, Colors.black.withOpacity(0.2)),
              context.emptySizedWidthBoxLow,
              tabBarRowItem(context, Colors.black.withOpacity(0.2)),
              context.emptySizedWidthBoxLow,
              tabBarRowItem(context, Colors.black.withOpacity(0.2)),
              context.emptySizedWidthBoxLow3x,
            ],
          ),
          context.emptySizedHeightBoxLow3x,
          appBarHeader(context, 'Popular', 24.0, Colors.pink),
          context.emptySizedHeightBoxLow,
          Padding(
            padding: context.horizontalPaddingMedium,
            child: Row(
              children: [
                Container(
                  width: context.width * 0.83,
                  height: context.height * 0.15,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Row(
                        children: [Text('data')],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container tabBarRowItem(BuildContext context, color) {
    return Container(
      alignment: Alignment.center,
      width: context.width * 0.2,
      height: context.height * 0.14,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.accessibility,
            size: 45,
            color: Colors.white,
          ),
          context.emptySizedHeightBoxLow,
          Text(
            'tabbarText',
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Padding appBarHeader(BuildContext context, text, size, color) {
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
