import 'package:bizeozel/core/components/colors/colors.dart';
import 'package:bizeozel/core/components/widgets/widgets.dart';
import 'package:bizeozel/views/PublicEducationPages/services/public_education_service.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kartal/kartal.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Position position;

  void _getUserPosition() async {
    await Geolocator.checkPermission();
    var userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      position = userLocation;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserPosition();
  }

  // ignore: missing_return
  Future<dynamic> getUserCity() async {
    final coordinates = Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    var city = first.addressLine.split('/')[1].split(',').first;
    return getPublicEducation(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          customAppBarArea(
            context,
            customAppBarBody(
                context, null, 'searching.png', 'BizeÖzel Eğitimlerden Faydalanın!', Colors.white, 0.05, false),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: context.height * 0.20,
              left: context.height * 0.04,
            ),
            child: Container(
              width: context.width * 0.9,
              height: context.height,
              child: FutureBuilder(
                future: getUserCity(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            postCardBodyArea(
                              context,
                              snapshot,
                              index,
                              0.15,
                              Column(
                                children: [
                                  Padding(
                                    padding: context.paddingLow,
                                    child: postCardHeaderRow(
                                      context,
                                      snapshot,
                                      index,
                                      snapshot.data[index].courseCentre.toString(),
                                      snapshot.data[index].courseCity.toString().split(' ')[1],
                                    ),
                                  ),
                                  postCardDescription(context, snapshot, index),
                                  postCardBottomRow(snapshot, index),
                                ],
                              ),
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

  Container postCardDescription(BuildContext context, AsyncSnapshot snapshot, int index) {
    return Container(
      alignment: Alignment.centerLeft,
      height: context.height * 0.05,
      constraints: BoxConstraints(maxWidth: context.width * 0.78),
      child: Text(
        snapshot.data[index].courseName.toString(),
        style: TextStyle(color: ColorPallette.color4.withOpacity(0.7)),
      ),
    );
  }

  Row postCardBottomRow(AsyncSnapshot snapshot, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        context.emptySizedWidthBoxLow3x,
        context.emptySizedWidthBoxLow,
        postCardBottomRowItem(snapshot, index, 30.0, 'schedule.png', snapshot.data[index].courseDates),
      ],
    );
  }

  Row postCardBottomRowItem(AsyncSnapshot snapshot, int index, iconSize, iconName, data) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/$iconName',
          height: iconSize,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          data.toString(),
          style: TextStyle(color: ColorPallette.color4),
        )
      ],
    );
  }
}
