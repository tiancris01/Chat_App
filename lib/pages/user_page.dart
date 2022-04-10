import 'package:flutter/material.dart';

import 'package:offertorio/models/usuarios.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class userPage extends StatefulWidget {
  @override
  _userPageState createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  RefreshController _refreshCtrl = RefreshController(initialRefresh: false);

  final users = [
    usuarios(
        uid: '1',
        name: 'Daniel',
        email: 'tiancris@gmail.com',
        onlineStatus: true),
    usuarios(
        uid: '2',
        name: 'Karen',
        email: 'tiancris@gmail.com',
        onlineStatus: false),
    usuarios(
        uid: '3',
        name: 'Cristian',
        email: 'tiancris@gmail.com',
        onlineStatus: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.grey[100],
          title: Text(
            'Mi nombre',
            style: TextStyle(color: Colors.black54),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onPressed: () {},
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

  ListTile _userListTile(usuarios u) {
    return ListTile(
      title: Text(u.name),
      leading: CircleAvatar(
        child: Text(
          u.name.substring(0, 2),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: u.onlineStatus ? Colors.green : Colors.red,
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
