import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:flutter/material.dart';
late LocationSettings locationSettings;

location() async {
  LocationPermission permission;

  if (defaultTargetPlatform == TargetPlatform.android) {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    print("==========>location");
    GeolocatorAndroid.registerWith();
    locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
//(Optional) Set foreground notification config to keep the app alive
//when going to the background
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText:
          "Example app will continue to receive your location even when you aren't using it",
          notificationTitle: "Running in Background",
          enableWakeLock: true,
        )
    );
  }

  StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position? position) {
        print(position == null ? 'Unknown' : '${position.latitude.toString()}=, ${position.longitude.toString()}');
      });
}