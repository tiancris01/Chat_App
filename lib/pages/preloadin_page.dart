import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:offertorio/services/auth_service.dart';
import 'package:offertorio/services/socket_service.dart';

import 'package:offertorio/pages/login_page.dart';
import 'package:offertorio/pages/user_page.dart';

class preloadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return Center(
              child: Text('Loading'),
            );
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authservice = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authservice.isLoggedIn();
    final socketService = Provider.of<SocketService>(context, listen: false);

    if (autenticado) {
      socketService.connect();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => userPage(),
            transitionDuration: Duration(microseconds: 0),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => loginPage(),
            transitionDuration: Duration(microseconds: 0),
          ));
    }
  }
}
