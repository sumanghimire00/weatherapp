import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getLocation() async {
    try {
      await _checkLocationPermissions();
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      e.toString();
      rethrow;
    }
  }
}

Future<LocationPermission> _checkLocationPermissions() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle permission denied scenario
    }
  }
  return permission;
}
