import 'package:flutter/material.dart';
import 'package:ugmaventon/pages/login_page.dart';
import '../pages/register_page.dart';

class AppRoutes{
  static const initialRoute = '/login';

  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    switch (settings.name){
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (context) => RegisterPage());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(child: Text('Pantalla no Encontrada')),
            ));
    }
  }
}