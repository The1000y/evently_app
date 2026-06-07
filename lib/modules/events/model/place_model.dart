import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final String id;
  final String name;
  final LatLng latLng;
  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> placesList = [
  PlaceModel(
    id: '1',
    name: 'محافظة السويس',
    latLng: LatLng(29.963836785064576, 32.55144238775983),
  ),
  PlaceModel(
    id: '2',
    name: 'كشري بالاس',
    latLng: LatLng(29.966480728880015, 32.553441032672374),
  ),
  PlaceModel(
    id: '3',
    name: 'مستفشى حميات السويس',
    latLng: LatLng(29.966783662321458, 32.54512730891518),
  ),
];
