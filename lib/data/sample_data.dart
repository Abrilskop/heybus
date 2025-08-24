import '../models/bus_route.dart';
import '../models/bus_stop.dart';
import '../models/lat_lng.dart'; // Cambiado

class SampleData {
  static List<BusRoute> get sampleBusRoutes {
    return [
      BusRoute(
        id: 'ruta-01',
        name: 'Servicio Rápido - Terminal a Wanchaq',
        stops: [
          BusStop(
            id: 'stop-1',
            name: 'Terminal Terrestre',
            position: LatLng(-13.5284, -71.9509),
            address: 'Terminal Terrestre Cusco, Av. Vallejo Santoni',
          ),
          BusStop(
            id: 'stop-2', 
            name: 'Colegio María Auxiliadora',
            position: LatLng(-13.5261, -71.9578),
          ),
          BusStop(
            id: 'stop-3',
            name: 'Clínica Paredes',
            position: LatLng(-13.5243, -71.9621),
          ),
          BusStop(
            id: 'stop-4',
            name: 'Mercado Wanchaq',
            position: LatLng(-13.5228, -71.9667),
            address: 'Mercado Central de Wanchaq, Cusco',
          ),
        ],
        pathCoordinates: [
          LatLng(-13.5284, -71.9509),
          LatLng(-13.5282, -71.9518),
          LatLng(-13.5278, -71.9532),
          LatLng(-13.5271, -71.9551),
          LatLng(-13.5265, -71.9567),
          LatLng(-13.5261, -71.9578),
          LatLng(-13.5256, -71.9592),
          LatLng(-13.5250, -71.9608),
          LatLng(-13.5245, -71.9620),
          LatLng(-13.5243, -71.9621),
          LatLng(-13.5238, -71.9635),
          LatLng(-13.5233, -71.9649),
          LatLng(-13.5229, -71.9660),
          LatLng(-13.5228, -71.9667),
        ],
      ),
      
      BusRoute(
        id: 'ruta-02',
        name: 'Ruta Batman - Centro Histórico',
        stops: [
          BusStop(
            id: 'stop-5',
            name: 'Puente Grau',
            position: LatLng(-13.5186, -71.9790),
          ),
          BusStop(
            id: 'stop-6',
            name: 'Playa Estacionamiento',
            position: LatLng(-13.5198, -71.9782),
          ),
          BusStop(
            id: 'stop-7',
            name: 'Av. El Sol - Koricancha',
            position: LatLng(-13.5173, -71.9774),
          ),
          BusStop(
            id: 'stop-8',
            name: 'Plaza de Armas',
            position: LatLng(-13.5160, -71.9788),
          ),
        ],
        pathCoordinates: [],
      ),
    ];
  }
}