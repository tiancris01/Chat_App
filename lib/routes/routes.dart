import 'package:flutter/cupertino.dart';

import 'package:offertorio/pages/chat_page.dart';
import 'package:offertorio/pages/login_page.dart';
import 'package:offertorio/pages/preloadin_page.dart';
import 'package:offertorio/pages/register_page.dart';
import 'package:offertorio/pages/user_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'users': (_) => userPage(),
  'chat': (_) => chatPage(),
  'login': (_) => loginPage(),
  'registro': (_) => registerPage(),
  'loading': (_) => preloadingPage(),
};
