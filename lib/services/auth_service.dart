import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> registerUser({
    required String name,
    required String last_name,
    required String email,
    required String phone,
    required String id,
    required String idPhotoUrl,
    required String carnetPhotoUrl,
    required String password,
  }) async {
    try {
      // Registrar user con firebaseauth
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      // Guardar el uid del user registrado
      String uid = userCredential.user!.uid;

      // Datos adicionales en FireStore
      await _firestore.collection('people').doc(uid).set({
        "name": name,
        "lastname": last_name,
        "email": email,
        "phone": phone,
        "id": id,
        "idPhoto": idPhotoUrl,
        "carnetPhoto": carnetPhotoUrl,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('El correo ya está en uso');
      } else if (e.code == 'weak-password') {
        throw Exception('La contraseña es demasiado débil');
      }
      throw Exception('Error desconocido: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Iniciar sesión
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  // Cerrar Sesion
  Future<void> logoutUser() async {
    await _firebaseAuth.signOut();
  }

  // Recuperar contraseña
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print('Error enviando correo de recuperación: $e');
      return false;
    }
  }

  // Usuario actual
  User? get currentUser => _firebaseAuth.currentUser;

  // Verificar si el usuario está autenticado
  bool isUserAuthenticated() {
    return _firebaseAuth.currentUser != null;
  }

  // Actualizar datos del perfil del usuario
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser!.updateDisplayName(displayName);
        await _firebaseAuth.currentUser!.updatePhotoURL(photoURL);
      }
    } catch (e) {
      throw Exception('Error al actualizar el perfil: $e');
    }
  }

  // Eliminar usuario (opcional)
  Future<void> deleteUser() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser!.delete();
      }
    } catch (e) {
      throw Exception('Error al eliminar el usuario: $e');
    }
  }
}

/*
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
}*/
