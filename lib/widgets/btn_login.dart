import 'package:flutter/material.dart';

class BotonLogin extends StatelessWidget {
  const BotonLogin({Key? key, required this.btnText, required this.onPress})
      : super(key: key);
  final String btnText;
  final void Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: this.onPress,
        child: Container(
          width: 100,
          child: Center(
            child: Text(
              this.btnText,
              style: TextStyle(
                color: Colors.black54,
                //fontWeight: FontWeight.bold,
                fontSize: 16,
                //letterSpacing: 1,
              ),
            ),
          ),
        ),
        style: ButtonStyle(
          shape:
              MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ))),
          elevation: MaterialStateProperty.all(3),
          backgroundColor: MaterialStateProperty.all(Colors.yellow),
        ),
      ),
    );
  }
}
