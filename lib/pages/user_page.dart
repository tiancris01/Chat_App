import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/usuarios.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';
import '../services/socket_service.dart';
import '../services/usuario_service.dart';

class userPage extends StatefulWidget {
  @override
  _userPageState createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  final usuarioService = UsuarioService();
  List<Usuario> users = [];
  RefreshController _refreshCtrl = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

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
              AuthService.deletToken();
              socketService.disconnect();
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: socketService.serverStatus == ServerStatus.Online
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(
                      Icons.offline_bolt,
                      color: Colors.red,
                    ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshCtrl,
          child: _listViewUser(),
          onRefresh: _cargarUsuarios,
          enablePullDown: true,
        ));
  }

  ListView _listViewUser() {
    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (_, i) => Divider(),
      itemBuilder: (_, i) => _userListTile(users[i]),
    );
  }

  ListTile _userListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(
          usuario.nombre.substring(0, 2),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: usuario.online ? Colors.green : Colors.red,
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargarUsuarios() async {
    this.users = await usuarioService.getUsuario();
    setState(() {});
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshCtrl.refreshCompleted();
  }
}
