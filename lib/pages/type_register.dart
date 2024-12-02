import 'package:flutter/material.dart';

class TypeRegisterPage extends StatelessWidget {
  const TypeRegisterPage({super.key});

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
                // Título UGMAVENTON
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

                // Agregar el Logo
                Image.asset(
                  'assets/logoapp.PNG', // Ruta de la imagen.
                  height: 200, // Tamaño del logo.
                ),
                const SizedBox(height: 30),

                // Botón Registrarse como Pasajero
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register_passenger');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFFAFAFA)),
                      ),
                      child: const Center(
                        child: Text(
                          'Registrarse como Pasajero',
                          style: TextStyle(
                            color: Color(0xFF003AA7),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Botón Registrarse como Conductor
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD900),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Registrarse como Conductor',
                          style: TextStyle(
                            color: Color(0xFF003AA7),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
