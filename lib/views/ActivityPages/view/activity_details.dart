import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

class AcitivityDetails extends StatefulWidget {
  @override
  _AcitivityDetailsState createState() => _AcitivityDetailsState();
}

TextEditingController _location = TextEditingController();

class _AcitivityDetailsState extends State<AcitivityDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
                                    'assets/icons/join.png',
                                    height: context.height * 0.073,
                                    width: context.height * 0.073,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                            ),
                            appBarHeader(context, 'BizeÖzel Etkinlik', 24.0, Colors.white),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -context.height * 0.04,
                        right: -50,
                        child: Container(
                          width: context.height * 0.22,
                          height: context.height * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(context.height * 0.1)),
                        ),
                      ),
                      Positioned(
                        bottom: -context.height * 0.1,
                        right: 70,
                        child: Container(
                          width: context.height * 0.22,
                          height: context.height * 0.2,
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(context.height * 0.1)),
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
                    width: context.width * 0.91,
                    height: context.height * 0.59,
                    child: Container(
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
                                    '  Kadın Dayanışması',
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                    style:
                                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff822659)),
                                  ),
                                ),
                                Text(
                                  '  İstanbul',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff822659).withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                          context.emptySizedHeightBoxLow3x,
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                height: context.height * 0.45,
                                constraints: BoxConstraints(maxWidth: context.width * 0.78),
                                child: Column(
                                  children: [
                                    Text(
                                      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown''',
                                      style: TextStyle(color: Color(0xff822659).withOpacity(0.7)),
                                    ),
                                    context.emptySizedHeightBoxLow,
                                    Container(
                                      width: context.width,
                                      height: 0.5,
                                      color: Colors.pink.withOpacity(0.5),
                                    ),
                                    context.emptySizedHeightBoxLow3x,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/calendar.png',
                                                  height: 30,
                                                ),
                                                context.emptySizedWidthBoxLow,
                                                Text(
                                                  '27/02/2021',
                                                  style:
                                                      TextStyle(color: Color(0xff822659), fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            context.emptySizedHeightBoxLow,
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/clock.png',
                                                  height: 30,
                                                ),
                                                context.emptySizedWidthBoxLow,
                                                Text(
                                                  '14:30',
                                                  style:
                                                      TextStyle(color: Color(0xff822659), fontWeight: FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Image.asset(
                                          'assets/icons/placeholder.png',
                                          height: 70,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
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
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.emptySizedHeightBoxLow,
                Row(
                  children: [
                    context.emptySizedWidthBoxHigh,
                    Container(
                      width: context.width * 0.85,
                      child: inputBox(context, 'Yorum Yazın...', 1),
                    )
                  ],
                ),
                context.emptySizedHeightBoxLow,
                Row(
                  children: [
                    context.emptySizedWidthBoxHigh,
                    Text(
                      'Yorumlar',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff822659)),
                    ),
                  ],
                ),
                Padding(
                  padding: context.horizontalPaddingMedium,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: context.width * 0.9,
                        height: 90,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            context.emptySizedWidthBoxLow,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(context.height * 0.0325),
                                  child: Image.network(
                                    'https://s3.amazonaws.com/f6s-public/profiles/1654735_original.jpg',
                                    height: context.height * 0.065,
                                    width: context.height * 0.065,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: context.verticalPaddingLow,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      context.emptySizedWidthBoxLow,
                                      Text(
                                        'Veli Bacik',
                                        style: TextStyle(
                                            fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff822659)),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        '@vb10',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff822659).withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: context.horizontalPaddingLow * 2,
                                    child: Container(
                                      constraints: BoxConstraints(maxWidth: context.width * 0.6, maxHeight: 50),
                                      child: Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since t',
                                        style: TextStyle(fontSize: 14, color: Color(0xff822659)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget inputBox(BuildContext context, text, line) {
    return TextFormField(
      onChanged: (value) {
        print(value.runtimeType);
      },
      controller: _location,
      maxLines: line,
      cursorColor: Colors.black,
      autofocus: false,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 15.0, color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Image.asset(
            'assets/icons/comment.png',
            height: 10,
          ),
        ),
        hintText: text,
        filled: true,
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffb34180)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffb34180)),
          borderRadius: BorderRadius.circular(10.0),
        ),
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