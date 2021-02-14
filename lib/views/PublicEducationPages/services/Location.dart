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
  Future<String> getUserCity() async {
    final coordinates = Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    var city = first.addressLine.split('/')[1].split(',').first;
    print(getPublicEducation(city));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          customAppBarArea(
            context,
            customAppBarBody(context, null, 'join.png', 'BizeÖzel Eğitimlerden Faydalanın!', null, 0.07),
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
                future: getPublicEducation('İstanbul'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return postCardBodyArea(context, snapshot, index, 0.2, Text('a'));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
