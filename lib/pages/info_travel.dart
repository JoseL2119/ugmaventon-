import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_globals.dart'; // Aquí se guarda geos y CorreoSelecion:D

class InfoTravel extends StatefulWidget {
  const InfoTravel({Key? key}) : super(key: key);

  @override
  State<InfoTravel> createState() => _InfoTravelPageState();
}

class _InfoTravelPageState extends State<InfoTravel> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Función para obtener los datos del conductor
  Future<Map<String, dynamic>> _getDriverData(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection('drivers')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("No se encontraron datos para el correo: $email");
        return {};
      }

      final data = querySnapshot.docs.first.data();
      print("Datos obtenidos para $email: $data");
      return data;
    } catch (e) {
      print("Error al obtener los datos del conductor: $e");
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userEmail = CorreoConductorRuta; // Usa el correo del conductor

    return FutureBuilder<Map<String, dynamic>>(
      future: _getDriverData(userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print("Error en el snapshot: ${snapshot.error}");
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print("No se encontraron datos para $userEmail");
          return Center(child: Text('No se encontraron datos'));
        }

        final data = snapshot.data!;
        print("Mostrando datos: $data");

        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xFFFFD900),
          appBar: AppBar(
            title: Center(
              child: Text(
                "${data['Punto_Partida'] ?? 'N/A'} -> ${"UGMA"}",
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
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          spreadRadius: 2.0)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 240,
                        color: Colors.grey[300],
                        child: Center(child: Text("Colocar el mapa acá")),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003AA7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          "VER RUTA",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        color: const Color(0xFF6D8DC7),
                        thickness: 4,
                        indent: 0,
                        endIndent: 0,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "INFORMACIÓN DEL AVENTÓN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 160,
                        color: const Color(0xFF6D8DC7),
                        child: Center(child: Text("ImgCar")),
                      ),
                      const SizedBox(height: 10),
                      Text(data['Tipo_Auto'] ?? 'N/A'),
                      const SizedBox(height: 10),
                      Text("Hora de salida: ${data['Hora_Salida'] ?? 'N/A'}"),
                      Text(
                          "Asientos disponibles: ${data['N_Asientos'] ?? 'N/A'}"),
                      Text("Aire Acondicionado: ${data['Aire'] ?? 'N/A'}"),
                      const SizedBox(height: 20),
                      Divider(
                        color: const Color(0xFF6D8DC7),
                        thickness: 4,
                        indent: 0,
                        endIndent: 0,
                      ),
                      const Text(
                        "DETALLES DEL VEHÍCULO",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Número de puertas: ${data['N_Puertas'] ?? 'N/A'}"),
                      Text(
                          "Número de asientos: ${data['N_Asientos'] ?? 'N/A'}"),
                      const SizedBox(height: 20),
                      Divider(
                        color: const Color(0xFF6D8DC7),
                        thickness: 4,
                        indent: 0,
                        endIndent: 0,
                      ),
                      const Text(
                        "DETALLES DEL CONDUCTOR",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                          "Nombre: ${data['Nombre'] ?? 'N/A'} ${data['Apellido'] ?? 'N/A'}"),
                      Text("Cédula: ${data['Cedula'] ?? 'N/A'}"),
                      Text("Teléfono: ${data['Telefono'] ?? 'N/A'}"),
                      const SizedBox(height: 20),
                      Divider(
                        color: const Color(0xFF6D8DC7),
                        thickness: 4,
                        indent: 0,
                        endIndent: 0,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003AA7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          "COORDINAR VIAJE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
