import 'package:flutter/material.dart';

class InfoTravel extends StatefulWidget {
  const InfoTravel({Key? key}) : super(key: key);

  @override
  State<InfoTravel> createState() => _InfoTravelPageState();
}

class _InfoTravelPageState extends State<InfoTravel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFD900),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Punto Partida -> Punto llegada",
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
                  // Coloca el mapa acá en vez de esto
                  Container(
                    height: 240,

                    color: Colors.grey[300],
                    child: Center(child: Text("Colocar el mapa acá")),
                  ),
                  const SizedBox(height: 20),
                  // Botón Ver Ruta
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

                  // Información del Aventón
                  const Text(
                    "INFORMACIÓN DEL AVENTÓN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Imagen de la moto (puedes reemplazar la imagen con un widget de imagen)
                  Container(
                    height: 160,
                    color: const Color(0xFF6D8DC7),
                    child: Center(child: Text("ImgCar")),
                  ),
                  const SizedBox(height: 10),
                  const Text("TypeCar"),
                  const SizedBox(height: 10),
                  // Detalles del viaje
                  const Text("Hora de salida: hora_salida"),
                  const Text("Asientos disponibles: asientos_disponibles"),
                  const Text("Aire Acondicionado: bool_AC"),
                  const SizedBox(height: 20),
                  // Detalles del vehículo

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
                  const Text("Año del vehículo: carro_anio"),
                  const Text("Número de puertas: num_puertas"),
                  const Text("Número de asientos: num_asientos"),
                  const SizedBox(height: 20),
                  // Detalles del conductor

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
                  const Text("Nombre: nombre_conductor"),
                  const Text("Cédula: ci_conductor"),
                  const Text("Teléfono: telefono_conductor"),
                  const SizedBox(height: 20),

                  Divider(
                    color: const Color(0xFF6D8DC7),
                    thickness: 4,
                    indent: 0,
                    endIndent: 0,
                  ),
                  // Botón de coordinar viaje
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
  }
}
