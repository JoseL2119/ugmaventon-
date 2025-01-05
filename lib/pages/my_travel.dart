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
                  const SizedBox(height: 20),
                  // Start Journey Section
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          const Color(0xFFFAFAFA), // Color del texto
                      backgroundColor:
                          const Color(0xFF003AA7), // Color de fondo
                      disabledBackgroundColor: const Color(0xFF6D8DC7),
                    ),
                    child: Text('INICIAR VIAJE'),
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
                        onPressed: () {},
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
                        onPressed: () {},
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
