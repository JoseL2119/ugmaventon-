import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

Future<bool> loginUser(String email, String password) async {
  try {
    // Hashear la contraseña ingresada
    //final hashedPassword = sha256.convert(utf8.encode(password)).toString();

    // Buscar el usuario en Firestore
    final querySnapshot = await FirebaseFirestore.instance
        .collection('people')
        .where('correo', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isEmpty) {
      print('Usuario no encontrado');
      return false;
    }

    // Verificar la contraseña
    final userData = querySnapshot.docs.first.data();
    if (userData['password'] == password) {
      print('Inicio de sesión exitoso');
      return true;
    } else {
      print('Contraseña incorrecta');
      return false;
    }
  } catch (e) {
    print('Error en el inicio de sesión: $e');
    return false;
  }
}