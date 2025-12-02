import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_app/utils/routes/app_routes.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        final textTheme = Theme.of(context).textTheme;
        return MaterialApp.router(
          title: 'Navigation App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2196F3),
              brightness: Brightness.light,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(textTheme).apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
            useMaterial3: true,
          ),
          themeMode: ThemeMode.light,
          routerConfig: AppRoutes.router,
        );
      },
    );
  }
}
