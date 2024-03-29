import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_with_google_map/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 14.0, target: LatLng(29.305103116405615, 30.84337813070837));
    initeMarkers();
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          initialCameraPosition: initialCameraPosition,
          cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            southwest: const LatLng(29.237473316139653, 30.796266668386423),
            northeast: const LatLng(29.413186683115622, 30.870589268673577),
          )),
          onMapCreated: (controller) {
            mapController = controller;
            initeMapStyle();
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              mapController.animateCamera(CameraUpdate.newLatLng(
                  const LatLng(29.318615183361143, 30.806710427942416)));
            },
            child: const Text('change location'),
          ),
        ),
      ],
    );
  }

  void initeMapStyle() async {
    var appStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_styles/aubergine.json");
    mapController.setMapStyle(appStyle);
  }

  void initeMarkers() {
    var myMarkers = places
        .map(
          (placeMarker) => Marker(
            markerId: MarkerId(placeMarker.id),
            position: placeMarker.latLng,
            infoWindow: InfoWindow(title: placeMarker.name),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }
}
