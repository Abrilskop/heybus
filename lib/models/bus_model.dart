import 'bus_stop_model.dart';

class Bus {
  final String id;
  final String routeName;
  final String imageUrl;
  final List<BusStop> idaStops; // Paraderos de ida
  final List<BusStop> vueltaStops; // Paraderos de vuelta

  Bus({
    required this.id,
    required this.routeName,
    required this.imageUrl,
    required this.idaStops,
    required this.vueltaStops,
  });
}