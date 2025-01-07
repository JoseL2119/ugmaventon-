import 'package:flutter/material.dart';
import 'package:ugmaventon/pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/type_register.dart'; // Importamos la pantalla de selección
import '../pages/register_passenger.dart'; // Importamos la pantalla de pasajeros
import '../pages/user_profile_page.dart'; // Importamos la pantalla de pasajeros
import '../pages/password_recovery_page.dart'; // Importamos la página de recuperación

import '../pages/create_travel.dart'; // Importamos la pantalla de crear aventones
import '../pages/Edit_travel.dart'; // Importamos la pantalla de crear aventones
import '../pages/mapatest.dart'; // testing
import '../pages/Elegir_Aventon.dart'; // testing
import '../pages/my_travel.dart'; // testing
import '../pages/info_travel.dart'; // testing
import '../pages/Mapa.dart'; // Ajusta la ruta según la ubicación real del archivo
import '../pages/Mapa2.dart'; // Ajusta la ruta según la ubicación real del archivo
import '../pages/MapaView.dart'; // Ajusta la ruta según la ubicación real del archivo

class AppRoutes {
  static const initialRoute = '/login';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case '/type_register':
        return MaterialPageRoute(
            builder: (context) => const TypeRegisterPage());
      case '/register_passenger':
        return MaterialPageRoute(
            builder: (context) => const RegisterPassengerPage());
      case '/user_profile':
        return MaterialPageRoute(builder: (context) => const UserProfilePage());
      case '/password_recovery':
        return MaterialPageRoute(
            builder: (context) => const PasswordRecoveryPage());

      case '/Edit_Travel':
        return MaterialPageRoute(builder: (context) => EditTravel());
      case '/Select_Travel':
        return MaterialPageRoute(builder: (context) => Select_Travel());
      case '/create_travel':
        return MaterialPageRoute(builder: (context) => CreateTravel());
      case '/mainMapa':
        return MaterialPageRoute(builder: (context) => const MyApp_Mapa());
      case '/MyApp_Mapa_EDITAR':
        return MaterialPageRoute(
            builder: (context) => const MyApp_Mapa_EDITAR());
      case '/View_Mapa':
        return MaterialPageRoute(builder: (context) => const View_Mapa());

      case '/mapatest':
        return MaterialPageRoute(builder: (context) => const MainMapaTest());

      case '/infotravel':
        return MaterialPageRoute(builder: (context) => const InfoTravel());

      case '/mytravel':
        return MaterialPageRoute(builder: (context) => const MyTravel());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Pantalla no Encontrada')),
          ),
        );
    }
  }
}
