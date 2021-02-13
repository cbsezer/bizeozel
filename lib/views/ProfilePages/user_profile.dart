import 'package:bizeozel/core/components/helpers/getcolorfromhex.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isclicked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                height: context.dynamicHeight(0.57),
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: getColorFromHex('383e56'),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 58.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _circleAvatar(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Barbara Palvin',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey.withOpacity(0.9),
                          ),
                          Text(
                            'Sivas,Merkez',
                            style: TextStyle(color: Colors.grey.withOpacity(0.9), fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildText('55', 'Etkinlik'),
                          buildText('150.000', 'Başvuru Sayısı'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                child: Container(
                  width: context.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tabBar(context, getColorFromHex('ef4f4f'), 'Etkinlik', true),
                      tabBar(context, getColorFromHex('ef4f4f'), 'İş ilanları', false)
                    ],
                  ),
                ),
              )
            ],
          ),
          context.emptySizedHeightBoxLow3x,
          Column(
            children: [
              Container(
                height: context.dynamicHeight(0.25),
                width: context.dynamicWidth(0.9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  //color: Colors.grey.withOpacity(0.2),
                ),
                child: Column(
                  children: [_isClickedIcerik()],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildText(text, text1) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text1,
          style: TextStyle(
            color: Colors.grey.withOpacity(0.9),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _isClickedIcerik() {
    if (isclicked == true) {
      return Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mayıs, 14',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.8),
                boxShadow: [BoxShadow(color: Colors.blueGrey)]),
            height: 90,
            child: Row(
              children: [
                Expanded(
                  flex: 33,
                  child: Image.asset(
                    'assets/icons/brainstorming.png',
                    height: 60,
                    width: 60,
                  ),
                ),
                Expanded(
                  flex: 66,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 50,
                        child: Center(child: Text('Buralara doğru gelin')),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mayıs, 14',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.grey.withOpacity(0.9),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
              boxShadow: [BoxShadow(color: Colors.blueGrey)]),
          height: 90,
          child: Row(
            children: [
              Expanded(
                flex: 33,
                child: Image.asset(
                  'assets/icons/brainstorming.png',
                  height: 60,
                  width: 60,
                ),
              ),
              Expanded(
                flex: 66,
                child: Column(
                  children: [
                    Expanded(
                      flex: 50,
                      child: Center(child: Text('İş ilanları burda')),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget tabBar(BuildContext context, color, text, tfmi) {
    return InkWell(
      onTap: () {
        setState(() {
          isclicked = tfmi;
        });
      },
      child: Container(
          width: context.width * 0.45,
          height: 50,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          )),
    );
  }

  Widget _circleAvatar() {
    return CircleAvatar(
        radius: 70,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://maheralayoubi.com/mohamad2/image/per4.jpeg'),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ));
  }
}
