import 'package:cloud_firestore/cloud_firestore.dart';

class Denuncia {
  final String id;
  final String autorId;
  final String autorNome;
  final String titulo;
  final String descricao;
  final String? imagemUrl;
  final DateTime data;

  Denuncia({
    required this.id,
    required this.autorId,
    required this.autorNome,
    required this.titulo,
    required this.descricao,
    this.imagemUrl,
    required this.data,
  });

  factory Denuncia.fromMap(String id, Map<String, dynamic> map) {
    return Denuncia(
      id: id,
      autorId: map['autorId'] ?? '',
      autorNome: map['autorNome'] ?? '',
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      imagemUrl: map['imagemUrl'],
      data: (map['data'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'autorId': autorId,
      'autorNome': autorNome,
      'titulo': titulo,
      'descricao': descricao,
      'imagemUrl': imagemUrl,
      'data': data,
    };
  }
}
