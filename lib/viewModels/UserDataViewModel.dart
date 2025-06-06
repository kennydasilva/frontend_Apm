import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDataViewModel extends ChangeNotifier {
  String? uid;
  String? nome;
  String? email;

  final _db = FirebaseFirestore.instance;

  Future<void> carregarDadosUsuario(String uidUsuario) async {
    final doc = await _db.collection('usuarios').doc(uidUsuario).get();
    if (doc.exists) {
      uid = doc['uid'];
      nome = doc['nome'];
      email = doc['email'];
      notifyListeners();
    }
  }

  void limparDados() {
    uid = null;
    nome = null;
    email = null;
    notifyListeners();
  }
}
