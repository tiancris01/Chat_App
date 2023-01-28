import 'package:http/http.dart' as http;

import '../global/env.dart';
import '../models/usuarios.dart';
import '../models/usuarios_response.dart';
import 'auth_service.dart';

class UsuarioService {
  Future<List<Usuario>> getUsuario() async {
    String? token = await AuthService.getToken();
    try {
      final resp = await http.get(Uri.parse('${Env.apiUrl}/usuarios'),
          headers: {
            'Content-Type': 'application/json',
            'x-Token': token.toString()
          });

      final usuarioResponse = usuariosResponseFromJson(resp.body);
      return usuarioResponse.usuarios;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
