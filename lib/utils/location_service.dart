import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<bool> checkandRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return false;
      }
      return false;
    }
    return true;
  }

  Future<bool> checkandRequestLocationPermission() async {
    var isPermissionGranted = await location.hasPermission();
    if (isPermissionGranted == PermissionStatus.deniedForever) {
      return false;
    }
    if (isPermissionGranted == PermissionStatus.denied) {
      isPermissionGranted = await location.requestPermission();
      return isPermissionGranted == PermissionStatus.granted;
    }
    return true;
  }

  void getRealTimeLocation({void Function(LocationData)? onData}) async {
    // location.changeSettings(distanceFilter: 2);
    location.onLocationChanged.listen(onData);
  }
}
