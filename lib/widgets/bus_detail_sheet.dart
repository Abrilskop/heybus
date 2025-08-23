import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/bus_model.dart';
import '../models/bus_stop_model.dart';

class BusDetailSheet extends StatelessWidget {
  final Bus bus;
  final ScrollController scrollController;

  const BusDetailSheet({super.key, required this.bus, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final stopsToShow = bus.idaStops;
    final Set<Marker> markers = stopsToShow.map((stop) {
      return Marker(
        markerId: MarkerId(stop.id),
        position: stop.location,
        infoWindow: InfoWindow(title: stop.name),
      );
    }).toSet();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        controller: scrollController,
        children: [
          // Handle para arrastrar
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          
          // MAPA
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: stopsToShow.isNotEmpty ? stopsToShow.first.location : const LatLng(0, 0),
                zoom: 14,
              ),
              markers: markers,
            ),
          ),

          // CONTENIDO DE INFORMACIÓN
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bus.routeName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Ruta Principal',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                ),
                const Divider(height: 32),

                // LISTA DE PARADEROS
                ...stopsToShow.map((stop) => _buildStopRow(context, stop, "5 min")),

                const Divider(height: 32),
                
                // BOTONES DE ACCIÓN
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(context, Icons.directions, 'Ruta Completa'),
                    _buildActionButton(context, Icons.favorite_border, 'Favoritos'),
                    _buildActionButton(context, Icons.share, 'Compartir'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStopRow(BuildContext context, BusStop stop, String arrivalTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          const Icon(Icons.directions_bus, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              stop.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            arrivalTime,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.green[700], fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label) {
    return TextButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}