import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//controladores/identificadores de lo que se agregue en los textFields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Color(0xFF003AA7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Titulo  UGMAVENTON
                SizedBox(
                  height: 10,
                ),
                Text(
                  'UGMAVENTÓN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFFFFD900)),
                ),
                SizedBox(
                  height: 20,
                ),

                //Agregar el Logo Aca
                Image.asset(
                  'assets/logoapp.PNG', // Ruta de la imagen.
                  height: 200, // Para ajustar el logo.
                ),
                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Color(0xFFFAFAFA)),
                      borderRadius: BorderRadius.circular(59),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Color(0xFFFAFAFA)),
                      borderRadius: BorderRadius.circular(59),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Contraseña',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //se te olvidó la contraseña?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '¿Se te olvidó tu contraseña?',
                        style: TextStyle(
                          color: Color(0xFFFAFAFA),
                        ),
                      ),
                    ],
                  ),
                ),
                //sign in button
                SizedBox(
                  height: 50,
                ),

                //Boton de IniciarSesion
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: 200, // Set the desired width
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFD900),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
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
                SizedBox(
                  height: 15,
                ),

                //Primera vez por aqui? Registrate?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Primera vez por aquí?',
                      style: TextStyle(
                        color: Color(0xFFFAFAFA),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        ' ¡Registrate!',
                        style: TextStyle(
                            color: Color(0xFFFAFAFA),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
                //not a member? register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}
