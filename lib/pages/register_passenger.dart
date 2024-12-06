import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ugmaventon/services/auth_service.dart';

class RegisterPassengerPage extends StatefulWidget {
  const RegisterPassengerPage({Key? key}) : super(key: key);

  @override
  State<RegisterPassengerPage> createState() => _RegisterPassengerPageState();
}

class _RegisterPassengerPageState extends State<RegisterPassengerPage> {
  bool termsAccepted = false;
  final AuthService _authService = AuthService();

  // Controladores para los campos de texto
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                  TextField(
                    controller: _firstNameController,
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
                  TextField(
                    controller: _lastNameController,
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
                  TextField(
                    controller: _emailController,
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
                  TextField(
                    controller: _phoneController,
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
                  TextField(
                    controller: _idNumberController,
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
                  TextField(
                    controller: _passwordController,
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
                  TextField(
                    controller: _confirmPasswordController,
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
                  ? () async {
                    String name = _firstNameController.text.trim();
                    String last_name = _lastNameController.text.trim();
                    String email = _emailController.text.trim();
                    String phone = _phoneController.text.trim();
                    String id = _idNumberController.text.trim();
                    String idPhotoUrl = 'sfd';
                    String carnetPhotoUrl = 'asd';

                    if (_firstNameController.text.isEmpty ||
                        _lastNameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _phoneController.text.isEmpty ||
                        _idNumberController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: Todos los campos son obligatorios")),
                      );
                      return;
                    }

                    if (_passwordController.text.trim() == _confirmPasswordController.text.trim()){
                      String password = _passwordController.text.trim();
                      try {
                        final register = await _authService.registerUser(
                          name: name,
                          last_name: last_name,
                          email: email,
                          phone: phone,
                          id: id,
                          idPhotoUrl: idPhotoUrl,
                          carnetPhotoUrl: carnetPhotoUrl,
                          password: password,
                        );
                        if (register) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Registro Exitoso')),
                          );
                          Navigator.pushNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                "Error: No se ha podido realizar el registro")),
                          );
                        }
                      } catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: Contraseñas diferentes")),
                      );
                      return;
                    }

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
