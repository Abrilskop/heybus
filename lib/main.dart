import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heybus/main_screen.dart';

// --- NUEVA PALETA DE COLORES MODERNA ---
class AppColors {
  static const Color primary = Color(0xFF6A5AE0); // Un morado vibrante
  static const Color background = Color(0xFFF0F2F5); // Un gris muy claro y limpio
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF1E2022);
  static const Color textSecondary = Color(0xFF77838F);
  static const Color accent = Color(0xFF48D6D2); // Un turquesa para acentos
}
// --- FIN DE LA PALETA ---

void main() {
  runApp(const HeyBusApp());
}

class HeyBusApp extends StatelessWidget {
  const HeyBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HeyBus',
      theme: ThemeData(
        // --- TEMA COMPLETAMENTE REDISEÑADO ---
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0, // AppBar sin sombra para un look plano
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
        useMaterial3: true,
        // --- FIN DEL REDISEÑO DEL TEMA ---
      ),
      home: const MainScreen(),
    );
  }
}