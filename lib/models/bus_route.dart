import 'lat_lng.dart'; // Cambiado
import 'bus_stop.dart';

class BusRoute {
  final String id;
  final String name;
  final List<BusStop> stops;
  final List<LatLng> pathCoordinates;

  BusRoute({
    required this.id,
    required this.name,
    required this.stops,
    required this.pathCoordinates,
  });
}