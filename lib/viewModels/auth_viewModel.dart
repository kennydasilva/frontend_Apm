import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:version3_firebase/viewmodels/UserDataViewModel.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;


  User? get currentUser => _auth.currentUser;

  Future<User?> login(String email, String password,UserDataViewModel userData) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);

    if (cred.user != null) {
      await userData.carregarDadosUsuario(cred.user!.uid);
    }

    notifyListeners();
    return cred.user;
  }

  Future<User?> register(String email, String password, String nome) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);if (cred.user != null) {
      try {
        await _db.collection('usuarios').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'nome': nome,
          'email': email,
          'createdAt': Timestamp.now(),
        });
      } catch (e) {
        debugPrint("Erro ao salvar usuário: $e");
      }
    }
    notifyListeners();
    return cred.user;
  }

  Future<void> logout(UserDataViewModel userData) async {
    await _auth.signOut();
    userData.limparDados();
    notifyListeners();
  }
}