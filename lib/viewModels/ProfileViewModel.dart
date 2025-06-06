import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:version3_firebase/models/denucias.dart';
import 'package:version3_firebase/viewmodels/UserDataViewModel.dart';


class ProfileViewModel extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  String get currentUserId => 'usuario_logado_id';

  Stream<List<Denuncia>> getUserPosts(UserDataViewModel userdata) {
    return _db
        .collection('Denuncia')
        .where('autorId', isEqualTo: userdata.uid)
        .orderBy('data', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Denuncia.fromMap(doc.id, doc.data())).toList());
  }

  Future<void> deleteDenuncia(String id) async {
    await _db.collection('Denuncia').doc(id).delete();
    notifyListeners();
  }

  Future<void> criarDenuncia({
    required String titulo,
    required String descricao,
    String? imagemUrl,
  }) async {
    await _db.collection('Denuncia').add({
      'autorId': currentUserId,
      'autorNome': 'Nome do Usuário',
      'titulo': titulo,
      'descricao': descricao,
      'imagemUrl': imagemUrl,
      'data': DateTime.now(),
    });
    notifyListeners();
  }

  Future<void> editarDenuncia(String id, {
    required String titulo,
    required String descricao,
    String? imagemUrl,
  }) async {
    await _db.collection('Denuncia').doc(id).update({
      'titulo': titulo,
      'descricao': descricao,
      if (imagemUrl != null) 'imagemUrl': imagemUrl,
    });
    notifyListeners();
  }

  Future<void> updateProfileName(String userId, String newName) async {
    await _db.collection('usuarios').doc(userId).update({'name': newName});
    notifyListeners();
  }
}