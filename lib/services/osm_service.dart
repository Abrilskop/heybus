import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/lat_lng.dart'; // Cambiado

class OSMService {
  static const String nominatimEndpoint = 'https://nominatim.openstreetmap.org';
  
  static Future<LatLng?> searchLocation(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$nominatimEndpoint/search?format=json&q=$query'),
        headers: {'User-Agent': 'HeyBusApp/1.0'},
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List && data.isNotEmpty) {
          final firstResult = data[0];
          return LatLng(
            double.parse(firstResult['lat']),
            double.parse(firstResult['lon']),
          );
        }
      }
    } catch (e) {
      print('Error searching location: $e');
    }
    return null;
  }
  
  static Future<String?> getAddressFromLatLng(LatLng position) async {
    try {
      final response = await http.get(
        Uri.parse('$nominatimEndpoint/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}'),
        headers: {'User-Agent': 'HeyBusApp/1.0'},
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['display_name'];
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return null;
  }
}