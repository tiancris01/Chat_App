import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:offertorio/services/auth_service.dart';

import 'package:offertorio/models/usuarios.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class userPage extends StatefulWidget {
  @override
  _userPageState createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  RefreshController _refreshCtrl = RefreshController(initialRefresh: false);

  final users = [
    Usuario(
        uid: '1',
        nombre: 'Daniel',
        //contras: '123456,',
        email: 'test1@gmail.com',
        online: true),
    Usuario(
        uid: '1',
        nombre: 'Karen',
        //contrasea: '123456,',
        email: 'test2@gmail.com',
        online: true),
    Usuario(
        uid: '1',
        nombre: 'Daniel',
        //contrasea: '123456,',
        email: 'test3@gmail.com',
        online: true),
  ];

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<authService>(context);
    final usuario = authservice.usuario;

    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.grey[100],
          title: Text(
            usuario.nombre,
            style: TextStyle(color: Colors.black54),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
              authService.deletToken();
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.black54,
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshCtrl,
          child: _ListViewUser(),
          onRefresh: _cargarUsuarios,
          enablePullDown: true,
        ));
  }

  ListView _ListViewUser() {
    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (_, i) => Divider(),
      itemBuilder: (_, i) => _userListTile(users[i]),
    );
  }

  ListTile _userListTile(Usuario u) {
    return ListTile(
      title: Text(u.nombre),
      leading: CircleAvatar(
        child: Text(
          u.nombre.substring(0, 2),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: u.online ? Colors.green : Colors.red,
        ),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshCtrl.refreshCompleted();
  }
}
