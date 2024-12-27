import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Select_Travel extends StatefulWidget {
  const Select_Travel({Key? key}) : super(key: key);

  @override
  State<Select_Travel> createState() => _Select_TravelPageState();
}

class _Select_TravelPageState extends State<Select_Travel> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elegir Aventón',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChooseRideScreen(),
    );
  }
}

class ChooseRideScreen extends StatefulWidget {
  @override
  _ChooseRideScreenState createState() => _ChooseRideScreenState();
}

class _ChooseRideScreenState extends State<ChooseRideScreen> {
  final Stream<QuerySnapshot> _driversStream =
      FirebaseFirestore.instance.collection('drivers').snapshots();
  List<String> _selectedReferences = [];
  List<DocumentSnapshot> _filteredDrivers = [];
  bool _isInUGMA = false;

  void _showReferenceDialog() async {
    final List<String>? results = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child:
              ReferenceSelectionWidget(selectedReferences: _selectedReferences),
        );
      },
    );

    if (results != null) {
      setState(() {
        _selectedReferences = results;
        _filterDrivers();
      });
    }
  }

  void _filterDrivers() {
    FirebaseFirestore.instance
        .collection('drivers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        _filteredDrivers =
            querySnapshot.docs.where((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

          if (_isInUGMA && data['Punto_Partida'] != 'ugma') {
            return false;
          }

          if (_selectedReferences.isEmpty) {
            return true;
          }

          if (_selectedReferences.contains('Otros')) {
            return true;
          }

          if (data['Referencias'] is List) {
            List<dynamic> referenciasList = data['Referencias'];
            return referenciasList
                .any((ref) => _selectedReferences.contains(ref));
          } else if (data['Referencias'] is String) {
            return _selectedReferences.contains(data['Referencias']);
          }
          return false;
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Elegir Aventón',
          style: TextStyle(color: Colors.yellow),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: _isInUGMA,
                onChanged: (bool? value) {
                  setState(() {
                    _isInUGMA = value ?? false;
                    _filterDrivers();
                  });
                },
              ),
              Text('Estoy en la UGMA'),
              Spacer(),
              ElevatedButton(
                onPressed: _showReferenceDialog,
                child: Text('Puntos de referencia'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredDrivers.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = _filteredDrivers[index];
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                // Filtrar documentos con campos incompletos
                if (data['Punto_Partida'] == null ||
                    data['Punto_Partida'].isEmpty ||
                    data['Referencias'] == null ||
                    (data['Referencias'] is List &&
                        (data['Referencias'] as List).isEmpty) ||
                    data['N_Asientos'] == null ||
                    data['Hora_Salida'] == null ||
                    data['Hora_Salida'].isEmpty) {
                  return Container();
                }

                String referencias;
                if (data['Referencias'] is List) {
                  referencias =
                      (data['Referencias'] as List<dynamic>).join(', ');
                } else {
                  referencias =
                      data['Referencias']?.toString() ?? 'Desconocido';
                }

                // Intercambiar Punto de Partida y Referencias si Punto de Partida es 'Otro'
                String puntoPartida = data['Punto_Partida'];
                if (puntoPartida.toLowerCase() == 'otro') {
                  puntoPartida = referencias;
                  referencias = 'UGMA';
                }

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              puntoPartida,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.arrow_forward, size: 24.0),
                            SizedBox(height: 4.0),
                            Text('Asientos: ${data['N_Asientos']}'),
                            Text('Salida: ${data['Hora_Salida']}'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              referencias,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
