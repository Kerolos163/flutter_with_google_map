import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_google_map/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController mapController;
  late Location location;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 14.0, target: LatLng(29.305103116405615, 30.84337813070837));
    // initeMarkers();
    // initePolylines();
    // initePolygons();
    // initCircles();
    location = Location();
    checkandRequestPermission();
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
          circles: circles,
          polygons: polygons,
          polylines: polylines,
          markers: markers,
          zoomControlsEnabled: false,
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

  void initeMarkers() async {
    var customMarker = BitmapDescriptor.fromBytes(await getImageFromRawData(
        imagePath: "assets/img/map-marker.png", width: 100));
    var myMarkers = places
        .map(
          (placeMarker) => Marker(
            markerId: MarkerId(placeMarker.id),
            position: placeMarker.latLng,
            infoWindow: InfoWindow(title: placeMarker.name),
            icon: customMarker,
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }

  Future<Uint8List> getImageFromRawData(
      {required String imagePath, required double width}) async {
    var imageData = await rootBundle.load(imagePath);
    var imageCodec = await ui.instantiateImageCodec(
        imageData.buffer.asUint8List(),
        targetWidth: width.round());
    var imageFrame = await imageCodec.getNextFrame();
    var imageByteData =
        await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);

    return imageByteData!.buffer.asUint8List();
  }

  void initePolylines() {
    Polyline polyline = const Polyline(
      polylineId: PolylineId("1"),
      color: Colors.blue,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      width: 5,
      points: [
        LatLng(29.318615183361143, 30.806710427942416),
        LatLng(29.305103116405615, 30.84337813070837),
      ],
    );
    polylines.add(polyline);
  }

  void initePolygons() {
    Polygon polygon = Polygon(
        strokeWidth: 2,
        fillColor: Colors.black.withOpacity(.5),
        polygonId: const PolygonId("1"),
        points: const [
          LatLng(29.321693195957774, 30.815363210144206),
          LatLng(29.32143127523634, 30.862098020019367),
          LatLng(29.299876637518498, 30.859694760742038),
          LatLng(29.305303146939195, 30.81373242706316),
        ],
        holes: const [
          [
            LatLng(29.315107556572592, 30.83210019439702),
            LatLng(29.310242890895783, 30.846648496093692),
            LatLng(29.303731360091998, 30.83149937957769),
          ]
        ]);
    polygons.add(polygon);
  }

  void initCircles() {
    Circle circle = Circle(
        circleId: const CircleId("1"),
        fillColor: Colors.blue.withOpacity(.5),
        strokeColor: Colors.black.withOpacity(.5),
        center: const LatLng(29.300117456644816, 30.833421321779685),
        radius: 1000);
    circles.add(circle);
  }

  void checkandRequestPermission() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        //to do
      }
    }
  }
}
