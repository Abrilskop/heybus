import 'lat_lng.dart'; // Cambiado

class BusStop {
  final String id;
  final String name;
  final LatLng position;
  final String? address;

  BusStop({
    required this.id,
    required this.name,
    required this.position,
    this.address,
  });
}