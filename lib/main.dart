import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/profil_page.dart';
import 'cubit/profil_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  ThemeData _lightTheme() {
    const neumorphismBase = Color(0xFFE0E5EC); 
    
    return ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.light,
      primaryColor: const Color(0xFF4F46E5),
      scaffoldBackgroundColor: neumorphismBase,
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF4F46E5),
        secondary: const Color(0xFF10B981),
        onSurface: Colors.black,
        surface: Colors.white,
      ),
      useMaterial3: true,
      cardTheme: const CardThemeData(
        elevation: 0,
        color: neumorphismBase,
      ),
    );
  }

  ThemeData _darkTheme() {
    const neumorphismBaseDark = Color(0xFF2E323A);
    
    return ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF6366F1),
      scaffoldBackgroundColor: neumorphismBaseDark,
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF6366F1),
        secondary: const Color(0xFF06D6A0),
        onSurface: Colors.white,
        surface: const Color(0xFF3E434D),
      ),
      useMaterial3: true,
      cardTheme: const CardThemeData(
        elevation: 0,
        color: neumorphismBaseDark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: MaterialApp(
        title: 'Profil Mahasiswa',
        debugShowCheckedModeBanner: false,
        theme: _lightTheme(),
        darkTheme: _darkTheme(),
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        
        home: ProfilPage(
          isDarkMode: _isDarkMode,
          toggleTheme: _toggleTheme,
        ),
      ),
    );
  }
}