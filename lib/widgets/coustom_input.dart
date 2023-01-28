import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.icon,
    required this.placeHolder,
    required this.textController,
    this.keyBoardType = TextInputType.text,
    this.isPassword = false,
  }) : super(key: key);

  final IconData icon;
  final String placeHolder;
  final TextEditingController textController;
  final TextInputType keyBoardType;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 5),
              blurRadius: 5,
            )
          ]),
      child: TextField(
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keyBoardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(this.icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeHolder,
        ),
      ),
    );
  }
}
