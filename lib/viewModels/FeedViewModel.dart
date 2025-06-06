import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:version3_firebase/models/denucias.dart';


class FeedViewModel extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  Stream<List<Denuncia>> getFeed() {
    return _db
        .collection('Denuncia')
        .orderBy('data', descending: true)
        .snapshots()
        .map((snapshot) {
      print('Quantidade de documentos: ${snapshot.docs.length}');
      return snapshot.docs.map((doc) {
        print('Dados do doc: ${doc.data()}');
        return Denuncia.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> compartilharPost(Denuncia post, String novoAutorId, String novoAutorNome) async {
    await _db.collection('Denuncia').add({
      'autorId': novoAutorId,
      'autorNome': novoAutorNome,
      'titulo': post.titulo,
      'descricao': post.descricao,
      'imagemUrl': post.imagemUrl,
      'data': DateTime.now(),
    });
  }
}