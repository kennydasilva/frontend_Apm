import 'package:cloud_firestore/cloud_firestore.dart';

class Comentario {
  final String id;
  final String autorNome;
  final String texto;
  final DateTime data;
  final List<Comentario> respostas;

  Comentario({
    required this.id,
    required this.autorNome,
    required this.texto,
    required this.data,
    this.respostas = const [],
  });

  factory Comentario.fromMap(String id, Map<String, dynamic> map) {
    return Comentario(
      id: id,
      autorNome: map['autorNome'],
      texto: map['texto'],
      data: (map['data'] as Timestamp).toDate(),
      respostas: [],
    );
  }
}