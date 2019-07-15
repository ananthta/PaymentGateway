import 'package:coromandel_mobile/Injection/dependency_injector.dart';
import 'package:coromandel_mobile/Utils/routes.dart';
import 'package:coromandel_mobile/app_config.dart';
import 'package:coromandel_mobile/ui/screens/login/LoginPage.dart';
import 'package:flutter/material.dart';

void main() {
  Injector.configure(Flavor.DEV);
//  LocationPicker.initApiKey(AppConfig.GOOGLE_MAP_API_KEY);

  runApp(new CoromandelApp());
}

class CoromandelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      checkerboardOffscreenLayers: false,
      title: AppConfig.APP_NAME,
      theme: null,
      routes: routes,
      home: new LoginPage(),
    );
  }
}
