import 'package:bizeozel/views/PublicEducationPages/services/public_education_service.dart';
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
    getPublicEducation('Adana');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                    borderRadius: BorderRadius.circular(context.height * 0.1),
                                  ),
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
            context.emptySizedHeightBoxLow,
            Padding(
              padding: context.horizontalPaddingMedium,
              child: Row(
                children: [
                  Container(
                    width: context.width * 0.83,
                    height: context.height * 0.17,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Padding(
                          padding: context.horizontalPaddingLow,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kadın Dayanışması',
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
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown',
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
            ),
            context.emptySizedHeightBoxLow,
            Padding(
              padding: context.horizontalPaddingMedium,
              child: Row(
                children: [
                  Container(
                    width: context.width * 0.83,
                    height: context.height * 0.17,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Padding(
                          padding: context.horizontalPaddingLow,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kadın Dayanışması',
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
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown',
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
            ),
            context.emptySizedHeightBoxLow,
            Padding(
              padding: context.horizontalPaddingMedium,
              child: Row(
                children: [
                  Container(
                    width: context.width * 0.83,
                    height: context.height * 0.17,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Padding(
                          padding: context.horizontalPaddingLow,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kadın Dayanışması',
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
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown',
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
            )
          ],
        ),
      ),
    );
  }

  Widget tabBarRowItem(BuildContext context, color) {
    return Container(
      alignment: Alignment.center,
      width: context.height * 0.09,
      height: context.height * 0.09,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.amilia,
            size: 30,
            color: Colors.white,
          ),
          context.emptySizedHeightBoxLow,
          Text(
            'tabbar',
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          )
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
