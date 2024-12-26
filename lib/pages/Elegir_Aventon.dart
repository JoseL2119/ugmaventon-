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
  List<String> _selectedReferences = [];

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
      });
    }
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
      body: Container(
        color: Colors.lightBlue[50],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
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
                itemCount: 5, // Número de elementos de la lista
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Alineamos los elementos en la parte superior
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Punto de partida',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text('Asientos: num_seats'),
                              Text('Salida: hora_salida'),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment
                                .start, // Alineamos las flechas con los títulos
                            children: [
                              Icon(Icons.arrow_forward, size: 24.0),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Punto de llegada',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text('Asientos: num_seats'),
                              Text('Salida: hora_salida'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Anterior'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Siguiente'),
                ),
              ],
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
