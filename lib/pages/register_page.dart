import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? selectedYear;
  bool? tintedWindows;
  String? doorCount; // Almacenará la opción seleccionada para las puertas.
  bool? hasAirConditioning;
  bool termsAccepted = false;
  String? selectedVehicle;

  final TextEditingController plateController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  final List<Map<String, String>> vehicleTypes = [
    {"label": "Mini", "icon": "directions_car"},
    {"label": "SUV", "icon": "directions_car_filled"},
    {"label": "Sedán", "icon": "commute"},
    {"label": "Compact", "icon": "electric_car"},
    {"label": "Moto", "icon": "two_wheeler"},
  ];

  String? uploadedLicense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFD900),
      appBar: AppBar(
        title: const Center(
          child: Text("Registro", style: TextStyle(color: Color(0xFFFFD900))),
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
                  BoxShadow(color: Colors.grey, blurRadius: 5.0, spreadRadius: 2.0)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Seleccione el vehículo que posee",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Selección de vehículos con scroll horizontal
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: vehicleTypes.map((vehicle) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedVehicle = vehicle["label"];
                            });
                          },
                          child: Container(
                            width: 100,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedVehicle == vehicle["label"]
                                    ? const Color(0xFF003AA7)
                                    : const Color.fromARGB(87, 0, 58, 167),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                  const SizedBox(height: 20),
                  // Año del vehículo
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "¿De qué año es su vehículo?",
                      labelStyle: const TextStyle(color: Colors.black),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7), width: 2),
                      ),
                    ),
                    items: List.generate(
                      30,
                      (index) {
                        int year = DateTime.now().year - index;
                        return DropdownMenuItem(
                          value: year.toString(),
                          child: Center(child: Text(year.toString())),
                        );
                      },
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Vidrios ahumados
                  const Text(
                    "¿Su vehículo tiene vidrios ahumados?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: tintedWindows,
                        onChanged: (value) {
                          setState(() {
                            tintedWindows = value;
                          });
                        },
                        activeColor: const Color(0xFF003AA7),
                      ),
                      const Text("Sí"),
                      const SizedBox(width: 30),
                      Radio<bool>(
                        value: false,
                        groupValue: tintedWindows,
                        onChanged: (value) {
                          setState(() {
                            tintedWindows = value;
                          });
                        },
                        activeColor: const Color(0xFF003AA7),
                      ),
                      const Text("No"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Número de puertas del vehículo
                  const Text(
                    "¿Cuántas puertas tiene su vehículo?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildDoorOption("2"),
                      _buildDoorOption("4"),
                      _buildDoorOption("No aplica"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Aire acondicionado
                  const Text(
                    "¿El vehículo tiene aire acondicionado?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: hasAirConditioning,
                        onChanged: (value) {
                          setState(() {
                            hasAirConditioning = value;
                          });
                        },
                        activeColor: const Color(0xFF003AA7),
                      ),
                      const Text("Sí"),
                      const SizedBox(width: 30),
                      Radio<bool>(
                        value: false,
                        groupValue: hasAirConditioning,
                        onChanged: (value) {
                          setState(() {
                            hasAirConditioning = value;
                          });
                        },
                        activeColor: const Color(0xFF003AA7),
                      ),
                      const Text("No"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Número de placa
                  TextField(
                    controller: plateController,
                    decoration: const InputDecoration(
                      labelText: "Número de placa",
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF003AA7)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Subir licencia o carnet
                  const Text(
                    "Adjunte una fotografía de su licencia o carnet de circulación:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        uploadedLicense = "Archivo subido correctamente";
                      });
                    },
                    child: const Text("Subir archivo"),
                  ),
                  if (uploadedLicense != null)
                    Text(
                      uploadedLicense!,
                      style: const TextStyle(color: Colors.green),
                    ),
                  const SizedBox(height: 20),
                  // Términos y condiciones
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
            Center(
              child: ElevatedButton(
                onPressed: _validateForm() ? _onSubmit : null,
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

  Widget _buildDoorOption(String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          doorCount = option;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: doorCount == option
              ? const Color(0xFF003AA7)
              : Colors.transparent,
          border: Border.all(color: const Color(0xFF003AA7)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: doorCount == option ? Colors.white : const Color(0xFF003AA7),
            fontWeight: FontWeight.bold,
          ),
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
        return Icons.help;
    }
  }

  bool _validateForm() {
    return selectedVehicle != null &&
        selectedYear != null &&
        tintedWindows != null &&
        hasAirConditioning != null &&
        doorCount != null &&
        plateController.text.isNotEmpty &&
        termsAccepted &&
        uploadedLicense != null;
  }

  void _onSubmit() {
    print("Formulario completado correctamente.");
  }
}
