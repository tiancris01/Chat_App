import 'package:flutter/material.dart';
import 'package:offertorio/services/socket_service.dart';
import 'package:provider/provider.dart';

import 'package:offertorio/services/auth_service.dart';

import 'package:offertorio/helpers/mostrar_alerta.dart';

import 'package:offertorio/widgets/btn_login.dart';
import 'package:offertorio/widgets/coustom_input.dart';
import 'package:offertorio/widgets/label.dart';
import 'package:offertorio/widgets/logo.dart';

class loginPage extends StatelessWidget {
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
                  titulo: 'Offertorio',
                ),
                _FormLogin(),
                Labels(
                  ruta: 'registro',
                  tituloLbl: 'Crear cuenta',
                  descipcionLbl: 'Es muy facil!',
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

class _FormLogin extends StatefulWidget {
  const _FormLogin({Key? key}) : super(key: key);

  @override
  State<_FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<_FormLogin> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
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
            btnText: 'Login',
            onPress: authservice.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authservice.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginOk) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      mostrarAlerta(
                          context, 'Login Incorrecto', 'Rivsa nuevamente');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
