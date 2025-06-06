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
    return _db.collection('denuncia').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Denuncia.fromMap(doc.id, doc.data())).toList());
  }