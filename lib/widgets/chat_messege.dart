import 'package:flutter/material.dart';

class chatMessege extends StatelessWidget {
  const chatMessege(
      {Key? key,
      required this.texto,
      required this.uid,
      required this.animationController})
      : super(key: key);

  final String texto;
  final String uid;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animationController,
        child: SizeTransition(
          sizeFactor: CurvedAnimation(
              parent: animationController, curve: Curves.easeOut),
          child: Container(
              child: this.uid == '123' ? _miMensaje() : _noMiMensaje()),
        ));
  }

  Widget _miMensaje() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 15, left: 50, right: 10),
        padding: EdgeInsets.all(10.0),
        child: Text(
          this.texto,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        decoration: BoxDecoration(
            color: Colors.amber[800], borderRadius: BorderRadius.circular(18)),
      ),
    );
  }

  Widget _noMiMensaje() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 15, left: 10, right: 50),
        padding: EdgeInsets.all(12.0),
        child: Text(
          this.texto,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
