import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ugmaventon/pages/mapatest.dart'; // Tu archivo con el mapa

import 'my_globals.dart'; // ACA SE GUARDA geos :D

class CreateTravel extends StatefulWidget {
  const CreateTravel({Key? key}) : super(key: key);

  @override
  State<CreateTravel> createState() => _CreateTravelPageState();
}

class _CreateTravelPageState extends State<CreateTravel> {
  TimeOfDay? _selectedTime;
  List<String> _selectedReferences = [];

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
            "Crear Aventón",
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
                          groupValue: 'puntoPartida',
                          onChanged: (value) {},
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text('Otro'),
                          value: 'otro',
                          groupValue: 'puntoPartida',
                          onChanged: (value) {},
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
                      Navigator.pushNamed(context, '/mainMapa');
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(geoString),
                            duration:
                                Duration(seconds: 3), // Duración del mensaje
                          ),
                        );
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

void actualizarDatosConductor(String correo) async {
  // Obtén una referencia a la colección de conductores
  CollectionReference drivers =
      FirebaseFirestore.instance.collection('Drivers');

  try {
    // Actualiza el documento del conductor con los campos específicos
    await drivers.doc(correo).update({
      'Punto_Partida': '',
      'Ruta': geos,
      'Hora_Salida': null,
      'Referencias': '',
    });
    SnackBar(content: Text("Datos actualizados exitosamente."));
  } catch (e) {
    SnackBar(content: Text("Error al actualizar los datos: $e"));
  }
}
