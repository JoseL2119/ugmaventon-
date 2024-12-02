import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPassengerPage extends StatefulWidget {
  const RegisterPassengerPage({super.key});

  @override
  State<RegisterPassengerPage> createState() => _RegisterPassengerPageState();
}

class _RegisterPassengerPageState extends State<RegisterPassengerPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? idPhotoPath;
  String? licensePhotoPath;
  bool termsAccepted = false;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFD900),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Registro de Pasajero",
            style: TextStyle(color: Color(0xFFFFD900)),
          ),
        ),
        backgroundColor: const Color(0xFF003AA7),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(color: Colors.grey, blurRadius: 5.0, spreadRadius: 2.0),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildTextField("Nombres", nameController),
                  const SizedBox(height: 20),
                  _buildTextField("Apellidos", lastNameController),
                  const SizedBox(height: 20),
                  _buildTextField("Correo Electrónico", emailController,
                      hintText: "ejemplo@correo.com"),
                  const SizedBox(height: 20),
                  _buildTextField("Teléfono Celular", phoneController,
                      hintText: "0424-5555555"),
                  const SizedBox(height: 20),
                  _buildTextField("Número de Cédula", idController),
                  const SizedBox(height: 20),
                  const Text("Foto de la Cédula"),
                  const SizedBox(height: 10),
                  _buildImagePickerButton(
                    "Cargar foto de cédula",
                    (path) => setState(() => idPhotoPath = path),
                  ),
                  const SizedBox(height: 20),
                  const Text("Foto del Carnet / Inscripción"),
                  const SizedBox(height: 10),
                  _buildImagePickerButton(
                    "Cargar foto del carnet",
                    (path) => setState(() => licensePhotoPath = path),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField("Contraseña", passwordController, obscureText: true),
                  const SizedBox(height: 20),
                  _buildTextField("Confirmar Contraseña", confirmPasswordController,
                      obscureText: true),
                  const SizedBox(height: 20),
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
                        checkColor: const Color(0xFFFFD900),
                        side: const BorderSide(color: Color(0xFF003AA7)),
                      ),
                      const Expanded(
                        child: Text("Acepto términos y condiciones"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _validateForm,
                child: const Text("Continuar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003AA7),
                  foregroundColor: const Color(0xFFFAFAFA),
                  disabledBackgroundColor: const Color(0xFF6D8DC7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? hintText, bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF003AA7)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF003AA7), width: 2),
        ),
      ),
    );
  }

  Widget _buildImagePickerButton(String label, Function(String?) onImagePicked) {
    return ElevatedButton.icon(
      onPressed: () async {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        onImagePicked(pickedFile?.path);
      },
      icon: const Icon(
        Icons.upload,
        color: Color(0xFF003AA7),
      ),
      label: Text(
        label,
        style: const TextStyle(color: Color(0xFF003AA7)),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFF003AA7)),
      ),
    );
  }

  void _validateForm() {
    if (nameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        idController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        idPhotoPath == null ||
        licensePhotoPath == null) {
      _showMessage("Por favor, complete todos los campos.");
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showMessage("Las contraseñas no coinciden.");
      return;
    }

    if (!termsAccepted) {
      _showMessage("Debe aceptar los términos y condiciones.");
      return;
    }

    // Acción después de validar correctamente
    _showMessage("Registro exitoso.");
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
