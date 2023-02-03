import 'package:app_invoices/providers/app_state.dart';
import 'package:app_invoices/providers/first_example_provider.dart';
import 'package:app_invoices/screens/screens.dart';
import 'package:app_invoices/services/navigation_service.dart';
import 'package:app_invoices/theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirstExampleProvider()),
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MaterialApp(
          title: 'App Invoices',
          debugShowCheckedModeBanner: false,
          initialRoute: LoginScreen.routerName,
          navigatorKey: NavigationService().navigationKey,
          routes: {
            LoginScreen.routerName: (_) => const LoginScreen(),
            HomeScreen.routerName: (_) => const HomeScreen(),
            SettingsScreen.routerName: (_) => const SettingsScreen(),
            SignaturePage.routerName: (_) => const SignaturePage(),
            WorkScreen.routerName: (_) => const WorkScreen(),
            NotRequirementsScreen.routerName: (_) =>
                const NotRequirementsScreen(),
          },
          theme: AppTheme.lightTheme),
    );
  }
}
