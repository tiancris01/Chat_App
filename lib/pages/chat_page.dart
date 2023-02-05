import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offertorio/models/mensajes_response.dart';
import '../services/auth_service.dart';
import '../services/chat_service.dart';
import '../services/socket_service.dart';
import '../widgets/chat_messege.dart';
import 'package:provider/provider.dart';

class chatPage extends StatefulWidget {
  @override
  _chatPageState createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> with TickerProviderStateMixin {
  final TextEditingController _textCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  List<ChatMessege> _messages = [];

  bool _escribiendo = false;

  @override
  void initState() {
    super.initState();

    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('msg_private', _listeningMsg);

    _msgHistory(this.chatService.userTo.uid);
  }

  void _msgHistory(String uid) async {
    List<Msg> chat = await this.chatService.getMsg(uid);
    final chatHistory = chat.map((m) => ChatMessege(
          texto: m.msg,
          uid: m.from,
          animationController: AnimationController(
              vsync: this, duration: Duration(milliseconds: 0))
            ..forward(),
        ));
    setState(() {
      _messages.insertAll(0, chatHistory);
    });
  }

  void _listeningMsg(dynamic payload) {
    ChatMessege messege = ChatMessege(
      texto: payload['msg'],
      uid: payload['from'],
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );
    setState(() {
      _messages.insert(0, messege);
    });

    messege.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userTo = this.chatService.userTo;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                userTo.nombre.substring(0, 2),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.yellow[600],
              maxRadius: 18,
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              userTo.nombre,
              style: TextStyle(color: Colors.black54, fontSize: 15),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                  controller: _textCtrl,
                  onSubmitted: _handleSubmit,
                  onChanged: (String texto) {
                    setState(() {
                      if (texto.trim().length > 0) {
                        _escribiendo = true;
                      } else {
                        _escribiendo = false;
                      }
                    });
                  },
                  decoration: InputDecoration.collapsed(
                    hintText: ('Enviar Texto'),
                  ),
                  focusNode: _focusNode),
            ),
            // Boton de enviar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: () {},
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.black87),
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(Icons.send),
                            onPressed: _escribiendo
                                ? () => _handleSubmit(_textCtrl.text.trim())
                                : null),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    _focusNode.requestFocus();
    _textCtrl.clear();

    final newMessage = new ChatMessege(
      texto: texto,
      uid: authService.usuario.uid,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 500)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _escribiendo = false;
    });

    this.socketService.emit('msg_private', {
      'from': this.authService.usuario.uid,
      'to': this.chatService.userTo.uid,
      'msg': texto,
    });
  }

  @override
  void dispose() {
    for (ChatMessege messege in _messages) {
      messege.animationController.dispose();
    }
    this.socketService.socket.off("msg_private");
    super.dispose();
  }
}
