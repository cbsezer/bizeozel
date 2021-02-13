import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Position position;

  void _getUserPosition() async {
    var permission = await Geolocator.checkPermission();
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

  void getUserCity() async {
    final coordinates = Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
// ignore: always_declare_return_types
    print('${first.addressLine.split('/')[0].split(' ').last}');
  }

  @override
  Widget build(BuildContext context) {
    getUserCity();
    print(position.latitude);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              position.latitude.toString(),
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}
