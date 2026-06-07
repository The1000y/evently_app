import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LinesModel {
  final String id;
  final List<LatLng> latLong;
  final Color color;
  final int width;

  LinesModel({
    required this.id,
    required this.latLong,
    required this.color,
    required this.width,
  });
}
