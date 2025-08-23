import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../main.dart'; // Importamos para acceder a AppColors
import '../models/bus_model.dart';
import '../models/bus_stop_model.dart';
import '../widgets/bus_detail_sheet.dart';

class BusListScreen extends StatefulWidget {
  const BusListScreen({super.key});

  @override
  State<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends State<BusListScreen> {
  // --- DATOS CON IMÁGENES DE UNSPLASH ---
  // Unsplash es perfecto para placeholders de alta calidad.
  final List<Bus> buses = [
    Bus(
      id: 'R-01',
      routeName: 'Servicio Rápido',
      // Usamos source.unsplash para obtener imágenes aleatorias por categoría
      imageUrl: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=400&q=80',
      idaStops: [
        BusStop(id: 'ida1-1', name: 'Terminal (Rápido)', location: const LatLng(-13.5284, -71.9509)),
        BusStop(id: 'ida1-2', name: 'Mercado Wanchaq', location: const LatLng(-13.5228, -71.9667)),
      ],
      vueltaStops: []
    ),
    Bus(
      id: 'R-02',
      routeName: 'Batman',
      imageUrl: 'https://images.unsplash.com/photo-1612916628677-475f676a6adf?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      idaStops: [
        BusStop(id: 'ida2-1', name: 'Puente Grau', location: const LatLng(-13.5186, -71.9790)),
        BusStop(id: 'ida2-2', name: 'Av. El Sol', location: const LatLng(-13.5173, -71.9774)),
      ],
       vueltaStops: []
    ),
    Bus(
      id: 'R-03',
      routeName: 'León de San Jerónimo',
      imageUrl: 'https://plus.unsplash.com/premium_photo-1664302152991-d013ff125f3f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YnVzfGVufDB8fDB8fHww',
      idaStops: [
        BusStop(id: 'ida3-1', name: 'San Jerónimo', location: const LatLng(-13.5495, -71.9019)),
        BusStop(id: 'ida3-2', name: 'Real Plaza', location: const LatLng(-13.5235, -71.9546)),
      ],
       vueltaStops: []
    ),
  ];

  void _showBusDetails(BuildContext context, Bus bus) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return BusDetailSheet(bus: bus, scrollController: scrollController);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutas de Bus'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        itemCount: buses.length,
        itemBuilder: (context, index) {
          final bus = buses[index];
          // --- TARJETA DE BUS COMPLETAMENTE REDISEÑADA ---
          return GestureDetector(
            onTap: () => _showBusDetails(context, bus),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // 1. IMAGEN REDONDEADA A LA IZQUIERDA
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      bus.imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 40, color: AppColors.textSecondary),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 2. TEXTO Y TAG A LA DERECHA
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bus.routeName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${bus.idaStops.length} paraderos principales',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // 3. ICONO INDICADOR A LA DERECHA
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.textSecondary,
                    size: 16,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}