import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? selectedYear;
  bool? tintedWindows;
  int? doorCount;
  bool termsAccepted = false;
  String? selectedVehicle;

  final List<Map<String, String>> vehicleTypes = [
    {"label": "Mini", "icon": "directions_car"},
    {"label": "SUV", "icon": "directions_car_filled"},
    {"label": "Sedán", "icon": "commute"},
    {"label": "Compact", "icon": "electric_car"},
    {"label": "Moto", "icon": "two_wheeler"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFFFD900),
      appBar: AppBar(
        title: Center(
          child: const Text("Registro", style: 
          TextStyle( color: Color(0xFFFFD900))),
        ),
        backgroundColor: Color(0xFF003AA7),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Espacio entre el contenido del formulario y el borde de la pantalla
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white, // Fondo blanco para el formulario
                borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
                boxShadow: const [
                  BoxShadow(color: Colors.grey, blurRadius: 5.0, spreadRadius: 2.0)
                ], // Sombras para el efecto
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Seleccione el vehículo que posee",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Primera fila de iconos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: vehicleTypes.sublist(0, 3).map((vehicle) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedVehicle = vehicle["label"];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedVehicle == vehicle["label"]
                                  ? Color(0xFF003AA7)
                                  : Color.fromARGB(87, 0, 58, 167),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                _getIconData(vehicle["icon"]!),
                                size: 40,
                              ),
                              const SizedBox(height: 5),
                              Text(vehicle["label"]!),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  // Segunda fila de iconos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: vehicleTypes.sublist(3).map((vehicle) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedVehicle = vehicle["label"];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedVehicle == vehicle["label"]
                                  ? Color(0xFF003AA7)
                                  : Color.fromARGB(87, 0, 58, 167),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                _getIconData(vehicle["icon"]!),
                                size: 40,
                              ),
                              const SizedBox(height: 5),
                              Text(vehicle["label"]!),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 250,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                        labelText: "¿De qué año es su vehículo?",
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Color(0xFF003AA7), width: 2), // Asegúrate que el color sea el mismo para cuando esté enfocado
),
                        
                        ),
                        items: List.generate(
                          30,
                          (index) {
                            int year = DateTime.now().year - index;
                            return DropdownMenuItem(
                              value: year.toString(),
                              child: Center(child: Text(year.toString(),)),
                            );
                          },
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedYear = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "¿Su vehículo tiene vidrios ahumados?",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: tintedWindows,
                            onChanged: (value) {
                              setState(() {
                                tintedWindows = value;
                              });
                            },
                            activeColor: Color(0xFF003AA7),
                          ),
                          const Text("Sí"),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Row(
                        children: [
                          Radio<bool>(
                            value: false,
                            groupValue: tintedWindows,
                            onChanged: (value) {
                              setState(() {
                                tintedWindows = value;
                              });
                            },
                            activeColor: Color(0xFF003AA7),
                          ),
                          const Text("No"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "¿Cuántas puertas tiene su vehículo?",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio<int>(
                            value: 2,
                            groupValue: doorCount,
                            onChanged: (value) {
                              setState(() {
                                doorCount = value;
                              });
                            },
                            activeColor: Color(0xFF003AA7),
                          ),
                          const Text("2 puertas"),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Row(
                        children: [
                          Radio<int>(
                            value: 4,
                            groupValue: doorCount,
                            onChanged: (value) {
                              setState(() {
                                doorCount = value;
                              });
                            },
                            activeColor: Color(0xFF003AA7),
                          ),
                          const Text("4 puertas"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<int>(
                          value: 0,
                          groupValue: doorCount,
                          onChanged: (value) {
                            setState(() {
                              doorCount = value;
                            });
                          },
                          activeColor: Color(0xFF003AA7),
                        ),
                        const Text("No aplica"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "¿Cuál es el color de su vehículo?",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF003AA7), width: 1), // Línea cuando no está seleccionado
                      ),
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF003AA7), width: 1),
                    ),
                  ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Adjunte una fotografía de su licencia de conducir o carnet de circulación",
                  ),
                  const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // Aquí puedes agregar funcionalidad para cargar imágenes
                  },
                  icon: const Icon(
                    Icons.upload,
                    color: Color(0xFF003AA7), // Color del icono
                  ),
                  label: const Text(
                    "Cargar imagen",
                    style: TextStyle(color: Color(0xFF003AA7)), // Color del texto
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Color de fondo del botón
                    foregroundColor: Color(0xFF003AA7), // Color del texto y el icono
                    side: BorderSide(color: Color(0xFF003AA7)), // Borde del botón
                  ),
                ),
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
                        activeColor: Color(0xFF003AA7), // Color cuando está marcado
                        checkColor: Color(0xFFFFD900), // Color del icono dentro del cuadro
                        side: BorderSide(color: Color(0xFF003AA7)), // Borde del cuadro
                      ),
                      const Expanded(
                        child: Text("Acepto términos y condiciones"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Botón fuera del formulario
            const SizedBox(height: 20), // Espacio entre el formulario y el botón
            Center(
              child: ElevatedButton(
                onPressed: termsAccepted
                    ? () {
                        // Aquí puedes manejar la acción del botón "Continuar"
                      }
                    : null,
                child: const Text("Continuar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003AA7),
                  foregroundColor: Color(0xFFFAFAFA),
                  disabledBackgroundColor: Color(0xFF6D8DC7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case "directions_car":
        return Icons.directions_car;
      case "directions_car_filled":
        return Icons.directions_car_filled;
      case "commute":
        return Icons.commute;
      case "electric_car":
        return Icons.electric_car;
      case "two_wheeler":
        return Icons.two_wheeler;
      default:
        return Icons.directions_car;
    }
  }
}