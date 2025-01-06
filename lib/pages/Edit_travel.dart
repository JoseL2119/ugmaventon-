import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_osm_interface/flutter_osm_interface.dart' as osm;
import 'package:ugmaventon/pages/mapatest.dart'; // Tu archivo con el mapa

import 'my_globals.dart'; // ACA SE GUARDA geos :D

class EditTravel extends StatefulWidget {
  const EditTravel({Key? key}) : super(key: key);

  @override
  State<EditTravel> createState() => _EditTravelPageState();
}

TimeOfDay? _selectedTime;
List<String> _selectedReferences = [];
// Variable para almacenar el valor seleccionado
String? puntoPartida = '';
bool isDataLoaded = false; //Controla si los datos ya se cargaron desde BD

class _EditTravelPageState extends State<EditTravel> {
  @override
  void initState() {
    //super.initState();
    if (!isDataLoaded) {
      cargarDatosConductor(context); // Cargar los datos al iniciar la página
    }
  }

  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      cancelText: 'Regresar',
      confirmText: 'Aceptar',
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFF6D8DC7),
              surface: Color(0xFAFAFAFA),
              onPrimary: Color(0xFAFAFAFA),
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _showReferenceSelection() async {
    final List<String> references = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ReferenceSelectionWidget(
          selectedReferences: _selectedReferences,
        );
      },
    );

    if (references != null) {
      setState(() {
        _selectedReferences = references;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFD900),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Editar Aventón",
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
                      color: Colors.grey, blurRadius: 5.0, spreadRadius: 2.0)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'PUNTO DE PARTIDA',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6D8DC7)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text('UGMA'),
                          value: 'ugma',
                          groupValue: puntoPartida,
                          onChanged: (value) {
                            setState(() {
                              puntoPartida =
                                  value; // Actualizamos el valor cuando se selecciona
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text('Otro'),
                          value: 'otro',
                          groupValue: puntoPartida,
                          onChanged: (value) {
                            setState(() {
                              puntoPartida =
                                  value; // Actualizamos el valor cuando se selecciona
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: const Color(0xFF6D8DC7),
                    thickness: 4,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Text(
                    'RUTA',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6D8DC7)),
                  ),
                  SizedBox(height: 20),
                  // Coloca el widget del mapa pequeño aquí
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/MyApp_Mapa_EDITAR');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          const Color(0xFFFAFAFA), // Color del texto
                      backgroundColor:
                          const Color(0xFF003AA7), // Color de fondo
                      disabledBackgroundColor: const Color(0xFF6D8DC7),
                    ),
                    child: Text('INDICAR RUTA'),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: const Color(0xFF6D8DC7),
                    thickness: 4,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Text(
                    'HORA DE SALIDA',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6D8DC7)),
                  ),
                  Text(
                    _selectedTime != null
                        ? '${_selectedTime!.format(context)}'
                        : 'NO DEFINIDA',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _pickTime,
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          const Color(0xFFFAFAFA), // Color del texto
                      backgroundColor:
                          const Color(0xFF003AA7), // Color de fondo
                      disabledBackgroundColor: const Color(0xFF6D8DC7),
                    ),
                    child: Text('INDICAR HORA'),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: const Color(0xFF6D8DC7),
                    thickness: 4,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Text(
                    'REFERENCIAS',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6D8DC7)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _showReferenceSelection,
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          const Color(0xFFFAFAFA), // Color del texto
                      backgroundColor:
                          const Color(0xFF003AA7), // Color de fondo
                      disabledBackgroundColor: const Color(0xFF6D8DC7),
                    ),
                    child: Text('Puntos de referencia'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${_selectedReferences.join(', ')}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: const Color(0xFF6D8DC7),
                    thickness: 4,
                    indent: 0,
                    endIndent: 0,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Aquí puedes hacer algo con userPos
                      //print(geos);
                      if (geos.length >= 2) {
                        String geoString = geos
                            .map((geo) =>
                                'Lat: ${geo.latitude}, Lon: ${geo.longitude}')
                            .join(', ');
                        /*ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(geoString),
                            duration:
                                Duration(seconds: 3), // Duración del mensaje
                          ),
                        );*/
                        actualizarDatosConductor(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          const Color(0xFFFAFAFA), // Color del texto
                      backgroundColor:
                          const Color(0xFF003AA7), // Color de fondo
                      disabledBackgroundColor: const Color(0xFF6D8DC7),
                    ),
                    child: Text('PUBLICAR AVENTÓN'),
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

  Future<void> cargarDatosConductor(BuildContext context) async {
    // Asegúrate de que el correo no esté vacío
    if (Correo?.isEmpty ?? true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("El correo no puede estar vacío."),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Obtén una referencia a la colección de conductores
    CollectionReference drivers =
        FirebaseFirestore.instance.collection('drivers');

    try {
      // Realiza una consulta para encontrar el conductor por correo
      QuerySnapshot querySnapshot =
          await drivers.where('email', isEqualTo: Correo).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Si encontramos el conductor, obtenemos el primer documento
        DocumentSnapshot driverSnapshot = querySnapshot.docs.first;

        // Obtén los datos del documento individualmente
        final punto = driverSnapshot.get('Punto_Partida') ?? '';
        setState(() {
          puntoPartida =
              punto; // Usamos directamente el valor de la base de datos
          _selectedTime =
              parseTimeOfDay(driverSnapshot.get('Hora_Salida') ?? '');
          _selectedReferences =
              List<String>.from(driverSnapshot.get('Referencias') ?? []);

          // Convertir el string almacenado en Firestore a List<GeoPoint>
          try {
            List<String> geoStringList = driverSnapshot.get('Ruta').split(', ');
            geos = [];
            for (int i = 0; i < geoStringList.length; i += 2) {
              final latStr = geoStringList[i].replaceFirst('Lat: ', '');
              final lonStr = geoStringList[i + 1].replaceFirst('Lon: ', '');
              final lat = double.tryParse(latStr);
              final lon = double.tryParse(lonStr);
              if (lat == null || lon == null) {
                throw FormatException(
                    'Invalid double value: Lat: $latStr, Lon: $lonStr');
              }
              geos.add(osm.GeoPoint(latitude: lat, longitude: lon));
            }
          } catch (e) {
            print("Error al procesar la ruta: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error al procesar la ruta: $e")),
            );
          }
        });

        isDataLoaded = true; // Marcamos que los datos han sido cargados
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Datos cargados exitosamente."),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        // Si no se encuentra el conductor, muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("El conductor no existe en la base de datos."),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Capturar cualquier error durante la operación
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al cargar los datos: $e"),
          duration: Duration(seconds: 3),
        ),
      );
      debugPrint("Error al cargar los datos: $e");
    }
  }
}

class ReferenceSelectionWidget extends StatefulWidget {
  final List<String> selectedReferences;

  ReferenceSelectionWidget({required this.selectedReferences});

  @override
  _ReferenceSelectionWidgetState createState() =>
      _ReferenceSelectionWidgetState();
}

class _ReferenceSelectionWidgetState extends State<ReferenceSelectionWidget> {
  List<String> _references = ['Altavista', 'San Felix', 'Curagua', 'Otros'];
  List<String> _tempSelectedReferences = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedReferences = List.from(widget.selectedReferences);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Seleccionar Referencias',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _references.length,
            itemBuilder: (BuildContext context, int index) {
              final reference = _references[index];
              final isSelected = _tempSelectedReferences.contains(reference);
              return CheckboxListTile(
                title: Text(reference),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _tempSelectedReferences.add(reference);
                    } else {
                      _tempSelectedReferences.remove(reference);
                    }
                  });
                },
              );
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _tempSelectedReferences);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFFAFAFA), // Color del texto
              backgroundColor: const Color(0xFF003AA7), // Color de fondo
              disabledBackgroundColor: const Color(0xFF6D8DC7),
            ),
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}

// Definir la función fuera del cuerpo de la clase para convertir la hora a String
String formatTimeOfDay(TimeOfDay time) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
}

void actualizarDatosConductor(BuildContext context) async {
  if ((puntoPartida?.isEmpty ?? true) ||
      (geos?.isEmpty ?? true) ||
      _selectedTime == null ||
      (_selectedReferences?.isEmpty ?? true) ||
      (Correo?.isEmpty ?? true)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Por favor, asegúrate de que todos los campos estén completos."),
        duration: Duration(seconds: 3),
      ),
    );
    return;
  }

  // Obtén una referencia a la colección de conductores
  CollectionReference drivers =
      FirebaseFirestore.instance.collection('drivers');

  String geoString = geos
      .map((geo) => 'Lat: ${geo.latitude}, Lon: ${geo.longitude}')
      .join(', ');

  // Formatea la hora de salida a String
  String horaSalida =
      _selectedTime != null ? formatTimeOfDay(_selectedTime!) : 'No definida';

  try {
    // Realizar una consulta para encontrar el conductor por correo
    QuerySnapshot querySnapshot = await drivers
        .where('email',
            isEqualTo: Correo) // Campo 'correo' con el valor proporcionado
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Si encontramos el conductor, obtenemos el primer documento (en caso de que haya más de uno)
      DocumentSnapshot driverSnapshot = querySnapshot.docs.first;

      // Actualizar los datos del conductor
      await drivers.doc(driverSnapshot.id).update({
        'Punto_Partida': puntoPartida,
        'Ruta': geoString,
        'Hora_Salida': horaSalida,
        'Referencias': _selectedReferences,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Datos actualizados exitosamente."),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pushNamed(context, '/mytravel');
    } else {
      // Si no se encuentra el conductor, muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("El conductor no existe en la base de datos."),
          duration: Duration(seconds: 3),
        ),
      );
    }
  } catch (e) {
    // Capturar cualquier error durante la operación
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error al actualizar los datos: $e"),
        duration: Duration(seconds: 3),
      ),
    );
    debugPrint("Error al actualizar los datos: $e");
  }
}

// Método para convertir una cadena de hora a TimeOfDay
TimeOfDay? parseTimeOfDay(String timeString) {
  if (timeString == 'No definida' || timeString.isEmpty) {
    return null;
  }
  final parts = timeString.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}
