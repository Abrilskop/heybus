import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/lat_lng.dart'; // Cambiado

class RoutingService {
  static const String osrmEndpoint = 'https://router.project-osrm.org/route/v1';
  
  static Future<List<LatLng>> calculateRoute(List<LatLng> waypoints) async {
    if (waypoints.length < 2) return waypoints;
    
    try {
      final coordinates = waypoints.map((point) => '${point.longitude},${point.latitude}').join(';');
      
      final response = await http.get(
        Uri.parse('$osrmEndpoint/driving/$coordinates?overview=full&geometries=geojson'),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final geometry = data['routes'][0]['geometry'];
        final coordinatesList = geometry['coordinates'] as List;
        
        return coordinatesList.map<LatLng>((coord) {
          return LatLng(coord[1].toDouble(), coord[0].toDouble());
        }).toList();
      }
    } catch (e) {
      print('Error calculating route: $e');
    }
    
    return waypoints;
  }
}