import 'package:flutter/material.dart';

import 'package:offertorio/widgets/btn_login.dart';
import 'package:offertorio/widgets/coustom_input.dart';
import 'package:offertorio/widgets/label.dart';
import 'package:offertorio/widgets/logo.dart';

class registerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(
                  titulo: 'Registro',
                ),
                _formLogin(),
                Labels(
                  ruta: 'login',
                  tituloLbl: 'login ',
                  descipcionLbl: 'Si ya tienes cuenta',
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Text('Terminos y condiciones de uso.',
                      style: TextStyle(color: Colors.black38, fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _formLogin extends StatefulWidget {
  const _formLogin({Key? key}) : super(key: key);

  @override
  State<_formLogin> createState() => __formLoginState();
}

class __formLoginState extends State<_formLogin> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.account_circle_outlined,
            placeHolder: 'nombre',
            keyBoardType: TextInputType.name,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.email_outlined,
            placeHolder: 'Email',
            keyBoardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outlined,
            placeHolder: 'password',
            //keyBoardType: TextInputType.,
            textController: passCtrl,
            isPassword: true,
          ),
          BotonLogin(
            btnText: 'Creat',
            onPress: null,
          ),
        ],
      ),
    );
  }
}
