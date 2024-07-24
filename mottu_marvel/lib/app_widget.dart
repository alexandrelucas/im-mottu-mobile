import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mottu_marvel/shared/services/local_storage/local_storage_service.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Clear cache when close app
    if (state == AppLifecycleState.detached) {
      Modular.get<LocalStorageService>().deleteAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: const String.fromEnvironment("APP_NAME"),
      debugShowCheckedModeBanner: false,
    );
  }
}
