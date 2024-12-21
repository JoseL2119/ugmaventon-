import 'package:flutter/material.dart';
import 'package:ugmaventon/pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/type_register.dart'; // Importamos la pantalla de selección
import '../pages/register_passenger.dart'; // Importamos la pantalla de pasajeros
import '../pages/create_travel.dart'; // Importamos la pantalla de crear aventones
import '../pages/mapatest.dart'; // testing

import '../Mapa/Mapa.dart'; // Ajusta la ruta según la ubicación real del archivo

class AppRoutes {
  static const initialRoute = '/create_travel';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case '/create_travel':
        return MaterialPageRoute(builder: (context) => CreateTravel());
      case '/register':
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case '/type_register':
        return MaterialPageRoute(
            builder: (context) => const TypeRegisterPage());
      case '/register_passenger':
        return MaterialPageRoute(
            builder: (context) => const RegisterPassengerPage());
      case '/mainMapa':
        return MaterialPageRoute(builder: (context) => const MyApp_Mapa());

      case '/mapatest':
        return MaterialPageRoute(builder: (context) => const MainMapaTest());

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Pantalla no Encontrada')),
          ),
        );
    }
  }
}
