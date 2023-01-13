import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class geolocation extends StatefulWidget {
  const geolocation({super.key});

  @override
  State<geolocation> createState() => _geolocationState();
}

class _geolocationState extends State<geolocation> {
  String locationMessage = 'Current Location:';
  String latitude = '';
  String longitude = '';

  void _liveLocaiton() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen((event) {
      latitude = event.latitude.toString();
      longitude = event.longitude.toString();

      setState(() {
        locationMessage = 'Location: $latitude, $longitude';
      });
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _openMap(String latitude, String longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    Uri googleUri = Uri.parse(googleUrl);

    await canLaunchUrl(googleUri) ? await launchUrl(googleUri) : throw 'Could not open $googleUrl.';
  }

  @override
  Widget build(BuildContext context) {
    double distanceInMeters = Geolocator.distanceBetween(31.58521592627035, 73.46940100123024, 31.58521592617035, 73.46940100193024);
    return Scaffold(
      appBar: AppBar(
        title: const Text('geolocation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(distanceInMeters.toString()),
            Text(locationMessage, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
                // backgroundColor: Colors.blueGrey,
                // foregroundColor: Colors.white,
              ),
              onPressed: () => _getCurrentLocation().then((value) => {
                latitude = value.latitude.toString(),
                longitude = value.longitude.toString(),
                setState(() {
                  locationMessage = 'Location: $latitude, $longitude';
                }),

                  _liveLocaiton(),
                // _openMap(latitude,longitude)
              }),
              child: const Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}