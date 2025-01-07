import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drivers',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DriversScreen(),
    );
  }
}

class DriversScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conductores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // StreamBuilder para mostrar los datos dinámicos de los conductores
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('drivers') // La colección de conductores
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                // Lista de conductores
                return Expanded(
                  child: Column(
                    children: [
                      // Mostrar la cantidad de conductores
                      Text(
                        'Cantidad de conductores: ${snapshot.data?.docs.length ?? 0}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16), // Espaciado

                      // Mostrar cada conductor
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            var driver = snapshot.data?.docs[index].data()
                                as Map<String, dynamic>;

                            return ListTile(
                              title: Text(driver.values.join(', ')),
                              subtitle: Text(driver.keys.join(', ')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
