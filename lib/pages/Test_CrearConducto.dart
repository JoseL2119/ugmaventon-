import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Conductores',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConductorForm(),
    );
  }
}

class ConductorForm extends StatefulWidget {
  @override
  _ConductorFormState createState() => _ConductorFormState();
}

class _ConductorFormState extends State<ConductorForm> {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController tipoAutoController = TextEditingController();
  final TextEditingController nAsientosController = TextEditingController();
  final TextEditingController nPuertasController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final TextEditingController telefonoController =
      TextEditingController(); // Nuevo controlador para el teléfono

  bool vidrioAhumado = false;
  bool aire = false;
  DateTime horaSalida = DateTime.now();
  List<String> ruta = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Conductor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Muestra la cantidad de conductores en la base de datos
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('drivers')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  // Verificar que los datos existan y luego obtener el número de conductores
                  final numConductores = snapshot.data?.docs.length ?? 0;

                  return Text(
                    'Número de conductores registrados: $numConductores',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  );
                },
              ),

              // Formulario de entrada de datos
              TextField(
                controller: cedulaController,
                decoration: InputDecoration(labelText: 'Cédula'),
              ),
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: apellidoController,
                decoration: InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: correoController,
                decoration: InputDecoration(labelText: 'Correo'),
              ),
              TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña'),
              ),
              TextField(
                controller: tipoAutoController,
                decoration: InputDecoration(labelText: 'Tipo de Auto'),
              ),
              TextField(
                controller: nAsientosController,
                decoration: InputDecoration(labelText: 'Número de Asientos'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: nPuertasController,
                decoration: InputDecoration(labelText: 'Número de Puertas'),
                keyboardType: TextInputType.number,
              ),
              CheckboxListTile(
                title: Text('Vidrio Ahumado'),
                value: vidrioAhumado,
                onChanged: (bool? value) {
                  setState(() {
                    vidrioAhumado = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Aire Acondicionado'),
                value: aire,
                onChanged: (bool? value) {
                  setState(() {
                    aire = value ?? false;
                  });
                },
              ),
              TextField(
                controller: placaController,
                decoration: InputDecoration(labelText: 'Placa del Auto'),
              ),
              TextField(
                controller:
                    telefonoController, // Nuevo campo para el número de teléfono
                decoration: InputDecoration(labelText: 'Número de Teléfono'),
                keyboardType: TextInputType.phone,
              ),
              ElevatedButton(
                onPressed: () async {
                  await _agregarConductor();
                },
                child: Text('Registrar Conductor'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _agregarConductor() async {
    final cedula = cedulaController.text;
    final nombre = nombreController.text;
    final apellido = apellidoController.text;
    final correo = correoController.text;
    final pass = passController.text;
    final tipoAuto = tipoAutoController.text;
    final nAsientos = int.tryParse(nAsientosController.text) ?? 0;
    final nPuertas = int.tryParse(nPuertasController.text) ?? 0;
    final placa = placaController.text;
    final telefono = telefonoController.text; // Recoger el número de teléfono

    // Aquí dejamos los campos vacíos o predeterminados
    final conductorData = {
      'Cedula': cedula,
      'Nombre': nombre,
      'Apellido': apellido,
      'email': correo,
      'password': pass, // Puedes encriptar la contraseña si es necesario
      'Tipo_Auto': tipoAuto,
      'N_Asientos': nAsientos,
      'N_Puertas': nPuertas,
      'Vidrio_Ahumado': vidrioAhumado,
      'Aire': aire,
      'Placa': placa,
      'Telefono': telefono, // Añadir el número de teléfono al objeto
      'FotoID':
          'url_a_foto_id', // Aquí puedes agregar un URL de Firebase Storage si es necesario
      'Punto_Partida': '', // Deja este campo vacío
      'Ruta': [], // Deja la lista vacía
      'Hora_Salida': null, // Deja este campo como null
      'Referencias': '', // Deja este campo vacío
    };

    try {
      // Agregar el conductor a la colección "drivers"
      await FirebaseFirestore.instance.collection('drivers').add(conductorData);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Conductor agregado correctamente")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al agregar conductor: $e")));
    }
  }
}
