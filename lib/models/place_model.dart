import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final String id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(
    id: '1',
    name: 'نادي محافظة الفيوم',
    latLng: const LatLng(29.318961703943717, 30.840125363769523),
  ),
  PlaceModel(
    id: '2',
    name: 'كشري السواقي',
    latLng: const LatLng(29.31028031228604, 30.842399877014138),
  ),
  PlaceModel(
    id: '3',
    name: 'ميدان المسلة',
    latLng: const LatLng(29.316629982349106, 30.85132509729486),
  ),
];
