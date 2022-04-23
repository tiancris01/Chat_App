import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:offertorio/routes/routes.dart';
import 'package:offertorio/services/auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => authService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Offertorio App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
