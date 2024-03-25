import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 14.0, target: LatLng(29.305103116405615, 30.84337813070837));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: initialCameraPosition,
      cameraTargetBounds: CameraTargetBounds(LatLngBounds(
        southwest: const LatLng(29.237473316139653, 30.796266668386423),
        northeast: const LatLng(29.413186683115622, 30.870589268673577),
      )),
    );
  }
}
