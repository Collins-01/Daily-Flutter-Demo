import 'package:daily_flutter_demo/presentation/screens/call/call_screen.dart';
import 'package:daily_flutter_demo/presentation/screens/lobby/lobby_screen.dart';
import 'package:daily_flutter_demo/presentation/screens/splashscreen/splashscreen.dart';
import 'package:daily_flutter_demo/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/lobby': (context) => const LobbyScreen(),
        '/call': (context) => const CallScreen(),
      },
    );
  }
}
