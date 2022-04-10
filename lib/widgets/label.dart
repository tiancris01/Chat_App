import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String tituloLbl;
  final String descipcionLbl;
  const Labels(
      {Key? key,
      required this.ruta,
      required this.tituloLbl,
      required this.descipcionLbl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(tituloLbl,
                style: TextStyle(
                    color: Colors.yellow[800],
                    fontSize: 18,
                    fontWeight: FontWeight.w800)),
          ),
          Text(descipcionLbl,
              style: TextStyle(
                color: Colors.black26,
                fontSize: 15,
              )),
        ],
      ),
    );
  }
}
