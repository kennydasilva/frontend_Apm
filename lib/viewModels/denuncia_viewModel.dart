import 'dart:io';
import 'package:apmt/models/denuncia_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';



class DenunciaViewModel extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Stream<List<Denuncia>> getDenuncias() {
    return _db.collection('Denuncia').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Denuncia.fromMap(doc.id, doc.data())).toList());
  }

  Future<String> salvarFotoLocalmente(File file) async {
    if (!file.existsSync()) {
      throw Exception("Arquivo não encontrado: ${file.path}");
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      final denunciaDir = Directory(path.join(directory.path, 'Denuncia'));
      if (!await denunciaDir.exists()) {
        await denunciaDir.create(recursive: true);
      }

      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}';
      final newPath = path.join(denunciaDir.path, fileName);

      final newFile = await file.copy(newPath);
      return newFile.path;
    } catch (e) {
      print("Erro ao salvar localmente: $e");
      rethrow;
    }
  }

  Future<void> criarDenuncia(String titulo, String descricao, File foto, UserDataViewModel userData) async {
    final fotoPath = await salvarFotoLocalmente(foto);
    await _db.collection('Denuncia').add({
      'titulo': titulo,
      'descricao': descricao,
      'imagemUrl': fotoPath,
      'autorId': userData.uid,
      'autorNome': userData.nome,
      'data': DateTime.now(),
    });
    notifyListeners();
  }


  Future<void> editarDenuncia(String id, String titulo, String descricao, {File? novaFoto}) async {
    String? fotoPath;
    if (novaFoto != null) {
      fotoPath = await salvarFotoLocalmente(novaFoto);
    }

    final data = {
      'titulo': titulo,
      'descricao': descricao,
      if (fotoPath != null) 'imagemUrl': fotoPath,
    };

    await _db.collection('Denuncia').doc(id).update(data);
    notifyListeners();
  }

  Future<void> apagarDenuncia(String id) async {
    await _db.collection('Denuncia').doc(id).delete();
    notifyListeners();
  }
}