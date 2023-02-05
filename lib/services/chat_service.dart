import 'package:flutter/material.dart';
import 'package:offertorio/models/mensajes_response.dart';
import 'package:offertorio/models/usuarios.dart';
import 'package:http/http.dart' as http;
import 'package:offertorio/services/auth_service.dart';

import '../global/env.dart';

class ChatService with ChangeNotifier {
  late Usuario userTo;

  Future<List<Msg>> getMsg(String userId) async {
    Uri url = Uri.parse('${Env.apiUrl}/mensajes/$userId');
    String? token = await AuthService.getToken();

    final resp = await http.get(
      url,
      headers: {'Content-Type': 'aplication/json', 'x-token': token!},
    );
    final msgResp = mensajesResponseFromJson(resp.body);
    print(msgResp.msg);
    return msgResp.msg;
  }
}
