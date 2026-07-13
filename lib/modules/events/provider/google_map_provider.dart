import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:location/location.dart';

class GoogleMapProvider extends ChangeNotifier {
  GoogleMapController? controller;
  String? mapStyle;
  var location = Location();

  Set<Marker> myMarkers = {};
  LocationData? lcationData;
  bool isFirstTimeCameraZoom = true;

  CameraPosition cameraPosition = CameraPosition(
    zoom: 1,
    target: LatLng(29.959879639851458, 32.55155278985297),
  );

  void initMapStyle(String mode) async {
    mapStyle = await rootBundle.loadString(mode);
    notifyListeners();
  }

  Future<Uint8List> getImagebits(String image) async {
    final myImage = await rootBundle.load(image);
    var biImage = myImage.buffer.asUint8List();
    var imageCodec = await ui.instantiateImageCodec(biImage);
    var imageFrameInfo = await imageCodec.getNextFrame();
    var byteData = await imageFrameInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData!.buffer.asUint8List();
  }

  Future<bool> checkAndRequestLocationServices() async {
    var isServicesEnable = await location.serviceEnabled();
    if (!isServicesEnable) {
      isServicesEnable = await location.requestService();
      if (!isServicesEnable) {
        return false;
      }
    }
    checkAndRequestLocationPersmission();

    return true;
  }

  Future<bool> checkAndRequestLocationPersmission() async {
    var persmisionStatus = await location.hasPermission();
    if (persmisionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (persmisionStatus == PermissionStatus.denied) {
      persmisionStatus = await location.requestPermission();

      return persmisionStatus == PermissionStatus.granted;
      // if (persmisionStatus != PermissionStatus.granted) {
      //   return false;
      // } else {
      //   return true;
      // }
    }
    return true;
  }

  Future<void> getLocationDate() async {
    location.changeSettings(distanceFilter: 2);
    location.onLocationChanged.listen((locationDate) async {
      if (isFirstTimeCameraZoom) {
        controller!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 15,
              target: LatLng(locationDate.latitude!, locationDate.longitude!),
            ),
          ),
        );
        isFirstTimeCameraZoom = false;
        notifyListeners();
      } else {
        controller!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(locationDate.latitude!, locationDate.longitude!),
          ),
        );
        notifyListeners();
      }
      BitmapDescriptor myLocation = await drawCustomMarker();

      var marker = Marker(
        icon: myLocation,
        markerId: MarkerId("1"),
        position: LatLng(locationDate.latitude!, locationDate.longitude!),
      );

      myMarkers.removeWhere((element) {
        return element.markerId == MarkerId("1");
      });
      myMarkers.add(marker);
      notifyListeners();
    });
  }

  Future<BitmapDescriptor> drawCustomMarker() async {
    BitmapDescriptor myLocation = BitmapDescriptor.bytes(
      await getImagebits('assets/images/location_icon.png'),
      height: 60,
      width: 40,
    );
    return myLocation;
  }

  void streamMyLocation() async {
    await checkAndRequestLocationServices();
    var hasPermission = await checkAndRequestLocationPersmission();
    if (hasPermission) {
      getLocationDate();
      notifyListeners();
    }
  }
}
