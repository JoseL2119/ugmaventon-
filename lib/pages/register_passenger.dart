import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPassengerPage extends StatefulWidget {
  const RegisterPassengerPage({Key? key}) : super(key: key);

  @override
  State<RegisterPassengerPage> createState() => _RegisterPassengerPageState();
}

class _RegisterPassengerPageState extends State<RegisterPassengerPage> {
  bool termsAccepted = false;

  // Controladores para los campos de texto
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  XFile? photo;

  Future getImageFromGallery() async {
    photo = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD900),
      appBar: AppBar(
        title: const Text(
          "Registro de Pasajero",
          style: TextStyle(color: Color(0xFFFFD900)),
        ),
        backgroundColor: const Color(0xFF003AA7),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Contenedor del formulario
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Campo: Nombres
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Nombres",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo: Apellidos
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Apellidos",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo: Correo electrónico
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Correo Electrónico",
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "ejemplo@correo.com",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo: Teléfono celular
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Teléfono Celular",
                      hintText: "Ejemplo: 0424-5555555",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo: Número de cédula
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Número de Cédula",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón para cargar foto de cédula
                  const Text("Adjunte una foto de su cédula"),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Acción para subir foto
                      getImageFromGallery();
                    },
                    icon: const Icon(
                      Icons.upload,
                      color: Color(0xFF003AA7),
                    ),
                    label: const Text(
                      "Cargar foto",
                      style: TextStyle(color: Color(0xFF003AA7)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF003AA7)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón para cargar foto del carnet/inscripción
                  const Text("Adjunte una foto del carnet/inscripción"),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Acción para subir foto
                      getImageFromGallery();
                    },
                    icon: const Icon(
                      Icons.upload,
                      color: Color(0xFF003AA7),
                    ),
                    label: const Text(
                      "Cargar foto",
                      style: TextStyle(color: Color(0xFF003AA7)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF003AA7)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo: Contraseña
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo: Confirmación de contraseña
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirmar Contraseña",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Aceptar términos
                  Row(
                    children: [
                      Checkbox(
                        value: termsAccepted,
                        onChanged: (value) {
                          setState(() {
                            termsAccepted = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF003AA7),
                      ),
                      const Expanded(
                        child: Text("Acepto los términos y condiciones"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Botón "Continuar"
            ElevatedButton(
              onPressed: termsAccepted
                  ? () {
                      // Acción al continuar
                    }
                  : null,
              child: const Text("Continuar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003AA7),
                disabledBackgroundColor: const Color(0xFF6D8DC7),
                foregroundColor: const Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
