import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offertorio/widgets/chat_messege.dart';

class chatPage extends StatefulWidget {
  @override
  _chatPageState createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> with TickerProviderStateMixin {
  final TextEditingController _textCtrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _escribiendo = false;

  List<chatMessege> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'TE',
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
              'Daniel Osorio',
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
                  ? CupertinoButton(child: Text('Enviar'), onPressed: () {})
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
                      )),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    print(texto);
    _focusNode.requestFocus();
    _textCtrl.clear();

    final newMessage = new chatMessege(
      texto: texto,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 500)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _escribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket
    for (chatMessege messege in _messages) {
      messege.animationController.dispose();
    }
    super.dispose();
  }
}
