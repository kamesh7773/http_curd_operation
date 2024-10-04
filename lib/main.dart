import 'package:flutter/material.dart';
import 'package:http_curd_operation/routes/routes.dart';
import 'package:http_curd_operation/routes/routes_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesNames.homePage,
      onGenerateRoute: Routes.genrateRoutes,
    );
  }
}
