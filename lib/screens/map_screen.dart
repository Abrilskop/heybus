import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Paquete auxiliar para las coordenadas

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos un Stack para poner el buscador encima del mapa
      body: Stack(
        children: [
          // WIDGET DEL MAPA (de flutter_map)
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(-12.046374, -77.042793), // Coordenadas de Lima, Perú
              initialZoom: 13.0,
            ),
            children: [
              // Esta es la capa que dibuja el mapa
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.innova.heybus', 
              ),
            ],
          ),

          // WIDGET DEL BUSCADOR (igual que antes)
          Positioned(
            top: 50,
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar paradero o destino...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}