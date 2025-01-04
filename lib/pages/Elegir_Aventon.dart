import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ugmaventon/routes/app_routes.dart';
import 'my_globals.dart'; // ACA SE GUARDA geos :D

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
      onGenerateRoute:
          AppRoutes.onGenerateRoute, // Esto lo conecta con AppRoutes

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
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFD900),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Elegir Aventón",
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
              margin: EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(8.0),
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
                      Text('En la UGMA'),
                      Spacer(),
                      ElevatedButton(
                        onPressed: _showReferenceDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6D8DC7),
                        ),
                        child: Text(
                            style: TextStyle(color: Colors.white),
                            'Puntos referencia'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: const Color(0xFF6D8DC7),
                    thickness: 4,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.6, // Ajustar la altura según el tamaño de la pantalla
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

                        if (puntoPartida == 'ugma') {
                          puntoPartida = "UGMA";
                        }

                        return GestureDetector(
                          onTap: () {
                            CorreoConductorRuta = data['email'];
                            Navigator.pushNamed(context, '/infotravel');
                          },
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
                                        Text('Asientos: ${data['N_Asientos']}'),
                                        Spacer(),
                                        Text('Salida: ${data['Hora_Salida']}'),
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
                ],
              ),
            ),
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
    // Activar "Otros" por defecto si no hay ninguna referencia seleccionada
    _tempSelectedReferences = widget.selectedReferences.isEmpty
        ? ['Otros']
        : List.from(widget.selectedReferences);

    Navigator.pop(context, _tempSelectedReferences);
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
                    _tempSelectedReferences = value == true ? [reference] : [];
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
