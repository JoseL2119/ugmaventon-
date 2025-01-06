import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ugmaventon/pages/mapatest.dart'; // Tu archivo con el mapa

import 'my_globals.dart'; // ACA SE GUARDA geos :D

class MyTravel extends StatefulWidget {
  const MyTravel({Key? key}) : super(key: key);

  @override
  State<MyTravel> createState() => _MyTravelPageState();
}

class _MyTravelPageState extends State<MyTravel> {
  int? nAsientos;
  String? horaSalida;
  String? driverId; // Para almacenar el ID del documento del conductor
  String? Partida;
  List<String> Referencias = ['Cargando'];

  @override
  void initState() {
    super.initState();
    fetchDriverData();
  }

  void fetchDriverData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('drivers')
        .where('email', isEqualTo: Correo)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot driverDoc = querySnapshot.docs.first;
      setState(() {
        if (driverDoc.get('Punto_Partida') == '' ||
            List<String>.from(driverDoc.get('Referencias')).toString() == '' ||
            (driverDoc.get('Ruta') as List).isEmpty ||
            driverDoc.get('Hora_Salida') == null) {
          Navigator.pushNamed(context, '/create_travel');
        }

        Partida = driverDoc.get('Punto_Partida');
        Referencias = List<String>.from(driverDoc.get('Referencias'));
        nAsientos = driverDoc.get('N_Asientos');
        horaSalida = driverDoc.get('Hora_Salida');
        driverId = driverDoc.id; // Guardar el ID del documento
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('No se encontró el conductor con el correo especificado.'),
          duration: Duration(seconds: 3), // Duración del mensaje
        ),
      );
    }
  }

  void clearDriverData() async {
    if (driverId != null) {
      FirebaseFirestore.instance.collection('drivers').doc(driverId).update({
        'Punto_Partida': '',
        'Ruta': [],
        'Hora_Salida': null,
        'Referencias': ''
      }).then((_) {
        Navigator.pushNamed(context, '/create_travel');
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al eliminar los datos del conductor: $error'),
            duration: Duration(seconds: 3),
          ),
        );
      });
    }
  }

  void updateSeatsInFirestore(int newSeats) async {
    if (driverId != null) {
      FirebaseFirestore.instance
          .collection('drivers')
          .doc(driverId)
          .update({'N_Asientos': newSeats}).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Disponibilidad de asientos actualizada en Firestore'),
            duration: Duration(seconds: 3), // Duración del mensaje
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Error al actualizar la disponibilidad de asientos: $error'),
            duration: Duration(seconds: 3), // Duración del mensaje
          ),
        );
      });
    }
  }

  void incrementSeats() {
    setState(() {
      nAsientos = (nAsientos ?? 0) + 1;
      updateSeatsInFirestore(nAsientos!);
    });
  }

  void decrementSeats() {
    if (nAsientos != null && nAsientos! > 0) {
      setState(() {
        nAsientos = nAsientos! - 1;
        updateSeatsInFirestore(nAsientos!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFD900),
      appBar: AppBar(
          title: Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: const Text(
          "Mi Aventón",
          style: TextStyle(color: Color(0xFFFFD900)),
        ),
      )),
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
                      color: Colors.grey, blurRadius: 5.0, spreadRadius: 2.0)
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.2, // Ajustar la altura según el tamaño de la pantalla
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        String referencias = Referencias.toString();

                        // Intercambiar Punto de Partida y Referencias si Punto de Partida es 'Otro'
                        String puntoPartida = Partida.toString();
                        if (puntoPartida.toLowerCase() == 'otro') {
                          puntoPartida = referencias;
                          referencias = 'UGMA';
                        }

                        if (puntoPartida == 'ugma') {
                          puntoPartida = "UGMA";
                        }

                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFF003AA7),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          color: Colors.grey[300],
                                          child: Center(child: Text("Typecar")),
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          puntoPartida,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward, size: 20.0),
                                        Text(
                                          referencias,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                            'Asientos: ${nAsientos ?? 'Cargando...'}'),
                                        Spacer(),
                                        Text(
                                            'Salida: ${horaSalida ?? 'Cargando...'}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  Divider(
                    color: const Color(0xFF6D8DC7),
                    thickness: 4,
                    indent: 0,
                    endIndent: 0,
                  ),
                  // Seat Availability Section
                  Text("DISPONIBILIDAD DE ASIENTOS"),

                  Divider(
                    color: const Color(0xFF6D8DC7),
                    thickness: 4,
                    indent: 0,
                    endIndent: 0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {},
                      ),
                      Text("ASIENTOS"),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  Divider(
                    color: const Color(0xFF6D8DC7),
                    thickness: 4,
                    indent: 0,
                    endIndent: 0,
                  ),

                  const SizedBox(height: 20),
                  // Map Section
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      width: double.infinity, // Ajusta el ancho
                      height: 250, // Puedes ajustar el alto si es necesario
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:
                            MainMapaTest(), // Aquí es donde se incluye el mapa
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Ride Options Section

                  Text("OPCIONES DE AVENTÓN"),

                  Divider(
                    color: const Color(0xFF6D8DC7),
                    thickness: 4,
                    indent: 0,
                    endIndent: 0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Edit_Travel');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color(0xFFFAFAFA), // Color del texto
                          backgroundColor:
                              const Color(0xFF003AA7), // Color de fondo
                          disabledBackgroundColor: const Color(0xFF6D8DC7),
                        ),
                        child: Text('EDITAR'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          clearDriverData();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color(0xFFFAFAFA), // Color del texto
                          backgroundColor:
                              const Color(0xFF003AA7), // Color de fondo
                          disabledBackgroundColor: const Color(0xFF6D8DC7),
                        ),
                        child: Text('REMOVER'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
