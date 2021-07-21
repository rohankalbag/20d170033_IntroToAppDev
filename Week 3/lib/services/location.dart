import 'package:location/location.dart';

class LocationGetter {
  Location location = new Location();
  String newLongitude = '';
  String newLatitude = '';

  Future<void> obtainLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    this.newLatitude = _locationData.latitude.toString();
    this.newLongitude = _locationData.longitude.toString();
  }
}