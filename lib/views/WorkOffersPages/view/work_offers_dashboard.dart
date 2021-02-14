import 'package:bizeozel/core/components/widgets/widgets.dart';
import 'package:bizeozel/views/ActivityPages/view/activity_details.dart';
import 'package:bizeozel/views/WorkOffersPages/services/get_work_offers_service.dart';
import 'package:bizeozel/views/WorkOffersPages/services/web_view.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WorkOffersDashboard extends StatefulWidget {
  @override
  _WorkOffersDashboardState createState() => _WorkOffersDashboardState();
}

class _WorkOffersDashboardState extends State<WorkOffersDashboard> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          customAppBarArea(
            context,
            customAppBarBody(
                context, null, 'searching.png', 'BizeÖzel İlanları Kaçırmayın!', Colors.white, 0.05, false),
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
                future: getWorkOffers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data.documents;
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            postCardBodyArea(
                              context,
                              snapshot,
                              index,
                              0.17,
                              postCardBody(context, snapshot, index, data),
                            ),
                            context.emptySizedHeightBoxLow
                          ],
                        );
                      },
                    );
                  } else {
                    return loadingAnimation();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column postCardBody(BuildContext context, AsyncSnapshot snapshot, int index, data) {
    return Column(
      children: [
        Padding(
          padding: context.paddingLow,
          child: postCardHeaderRow(
            context,
            snapshot,
            index,
            data[index]['WorkName'],
            data[index]['CityName'].length > 15
                ? data[index]['CityName'].toString().substring(0, 15)
                : data[index]['CityName'],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          height: context.height * 0.055,
          constraints: BoxConstraints(
            maxWidth: context.width * 0.78,
          ),
          child: Text(
            data[index]['CompName'],
            maxLines: 2,
            style: TextStyle(fontSize: 17, color: Color(0xff822659).withOpacity(0.7)),
          ),
        ),
        context.emptySizedHeightBoxLow,
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
                        data[index]['PublishDate'],
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WorkWebView(data[index]['WorkHref'].toString(), data[index]['WorkName'])),
                      );
                      print(data[index]['WorkHref'].toString());
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff822659),
                      size: 30,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
