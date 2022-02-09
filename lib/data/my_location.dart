import 'package:geolocator/geolocator.dart';

class MyLocation {
  late double latitude2;
  late double longitude2;

  Future<void> getMyCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    // bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // await Geolocator.checkPermission();
    // await Geolocator.requestPermission();

    try {
      //await을 사용 해야 함
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;

      print("나의 latitude ${latitude2} longitude: ${longitude2}");
    } catch (e) {
      print(e);
    }
  }
}
