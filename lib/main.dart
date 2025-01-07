import 'package:flutter/material.dart';
import 'package:ugmaventon/routes/app_routes.dart';
import 'widgets/chat_wrapper.dart';

// Importaciones de Firebase y FireStore
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatWrapper(
        child: Navigator(
          initialRoute: AppRoutes.initialRoute,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          // O tu configuración existente de rutas
        ),
      ),
    );
  }
}