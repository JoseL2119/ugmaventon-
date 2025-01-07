import 'package:flutter/material.dart';
import 'package:ugmaventon/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Asegúrate de tener esta importación
import 'my_globals.dart'; // ACA SE GUARDA geos :D

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService _authService = AuthService();

  // Controladores de los campos de texto
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003AA7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'UGMAVENTÓN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xFFFFD900),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/logoapp.PNG', // Ruta de la imagen.
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: const Color(0xFFFAFAFA)),
                      borderRadius: BorderRadius.circular(59),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: const Color(0xFFFAFAFA)),
                      borderRadius: BorderRadius.circular(59),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Contraseña',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/password_recovery');
                        },
                        child: const Text(
                          '¿Se te olvidó tu contraseña?',
                          style: TextStyle(
                            color: Color(0xFFFAFAFA),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      Correo = email;

                      final success = await _authService.loginUser(
                        email: email,
                        password: password,
                      );

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Inicio Exitoso")),
                        );

                        // Redirigir a la pantalla de perfil de usuario
                        Navigator.pushNamed(context, '/Select_Travel');
                      } else {
                        Correo = email;
                        // Buscar en la colección drivers en Firestore
                        final driversCollection =
                            FirebaseFirestore.instance.collection('drivers');
                        final driver = await driversCollection
                            .where('email', isEqualTo: email)
                            .where('password', isEqualTo: password)
                            .get();
                        if (driver.docs.isNotEmpty) {
                          Navigator.pushNamed(context, '/mytravel');
                        } else {
                          // Manejar el caso donde no se encuentra el documento
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Correo o Contraseña incorrectos')),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD900),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            color: Color(0xFF003AA7),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Primera vez por aquí?',
                      style: TextStyle(
                        color: Color(0xFFFAFAFA),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/type_register');
                      },
                      child: const Text(
                        ' ¡Registrate!',
                        style: TextStyle(
                          color: Color(0xFFFAFAFA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
