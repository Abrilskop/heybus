import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStop {
  final String id;
  final String name;
  final LatLng location; // Coordenadas geográficas del paradero

  BusStop({
    required this.id,
    required this.name,
    required this.location,
  });
}