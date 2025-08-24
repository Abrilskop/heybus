import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import '../models/bus_route.dart';
import '../services/routing_service.dart';
import '../models/lat_lng.dart';

class BusMapScreen extends StatefulWidget {
  final List<BusRoute> busRoutes;

  const BusMapScreen({super.key, required this.busRoutes});

  @override
  State<BusMapScreen> createState() => _BusMapScreenState();
}

class _BusMapScreenState extends State<BusMapScreen> {
  final MapController mapController = MapController();
  List<latlong2.LatLng> currentRoutePath = [];
  BusRoute? selectedRoute;
  latlong2.LatLng _mapCenter = const latlong2.LatLng(-13.53195, -71.96746);
  double _mapZoom = 13.0;

  // Convertir nuestra LatLng a latlong2.LatLng para flutter_map
  latlong2.LatLng _toFlutterMapLatLng(LatLng latLng) {
    return latlong2.LatLng(latLng.latitude, latLng.longitude);
  }

  @override
  void initState() {
    super.initState();
    
    if (widget.busRoutes.isNotEmpty) {
      selectedRoute = widget.busRoutes.first;
      _loadRoutePath(selectedRoute!);
    }
  }

  Future<void> _loadRoutePath(BusRoute route) async {
    if (route.pathCoordinates.isNotEmpty) {
      setState(() {
        currentRoutePath = route.pathCoordinates.map(_toFlutterMapLatLng).toList();
      });
    } else {
      final waypoints = route.stops.map((stop) => stop.position).toList();
      final calculatedPath = await RoutingService.calculateRoute(waypoints);
      
      setState(() {
        currentRoutePath = calculatedPath.map(_toFlutterMapLatLng).toList();
      });
    }
    
    _fitMapToRoute();
  }

  void _fitMapToRoute() {
    if (currentRoutePath.isNotEmpty) {
      // Calcular los límites del bounding box manualmente
      double minLat = currentRoutePath.first.latitude;
      double maxLat = currentRoutePath.first.latitude;
      double minLng = currentRoutePath.first.longitude;
      double maxLng = currentRoutePath.first.longitude;

      for (final point in currentRoutePath) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLng) minLng = point.longitude;
        if (point.longitude > maxLng) maxLng = point.longitude;
      }

      // Calcular el centro
      final center = latlong2.LatLng(
        (minLat + maxLat) / 2,
        (minLng + maxLng) / 2,
      );

      // Calcular el zoom level aproximado
      final latDiff = maxLat - minLat;
      final lngDiff = maxLng - minLng;
      final maxDiff = latDiff > lngDiff ? latDiff : lngDiff;
      
      double zoomLevel = 13.0;
      if (maxDiff < 0.01) zoomLevel = 15.0;
      if (maxDiff < 0.005) zoomLevel = 16.0;
      if (maxDiff < 0.001) zoomLevel = 17.0;
      if (maxDiff > 0.05) zoomLevel = 12.0;
      if (maxDiff > 0.1) zoomLevel = 11.0;
      if (maxDiff > 0.2) zoomLevel = 10.0;

      // Actualizar el estado con el nuevo centro y zoom
      setState(() {
        _mapCenter = center;
        _mapZoom = zoomLevel;
      });

      // Opcional: También puedes usar el mapController si prefieres
      mapController.move(center, zoomLevel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Rutas de Bus - Cusco'),
        backgroundColor: const Color(0xFF6A5AE0),
        foregroundColor: Colors.white,
        actions: [
          if (widget.busRoutes.length > 1)
            PopupMenuButton<BusRoute>(
              onSelected: (route) {
                setState(() {
                  selectedRoute = route;
                });
                _loadRoutePath(route);
              },
              itemBuilder: (context) => widget.busRoutes.map((route) {
                return PopupMenuItem<BusRoute>(
                  value: route,
                  child: Text(route.name),
                );
              }).toList(),
              icon: const Icon(Icons.route, color: Colors.white),
            ),
        ],
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: _mapCenter, // Cambiado de 'center' a 'initialCenter'
          initialZoom: _mapZoom,     // Cambiado de 'zoom' a 'initialZoom'
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.heybus.app',
          ),
          
          PolylineLayer(
            polylines: [
              if (currentRoutePath.isNotEmpty)
                Polyline(
                  points: currentRoutePath,
                  color: const Color(0xFF6A5AE0),
                  strokeWidth: 4.0,
                ),
            ],
          ),
          
          MarkerLayer(
            markers: [
              if (selectedRoute != null)
                ...selectedRoute!.stops.map((stop) => Marker(
                  point: _toFlutterMapLatLng(stop.position),
                  width: 40.0,
                  height: 40.0,
                  child: Icon( // Cambiado de 'builder' a 'child'
                    Icons.location_pin,
                    color: Colors.red,
                    size: 30.0,
                  ),
                )),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fitMapToRoute,
        backgroundColor: const Color(0xFF6A5AE0),
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}