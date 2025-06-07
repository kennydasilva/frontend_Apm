import 'package:cloud_firestore/cloud_firestore.dart';

class Notificacao {
  final String id;
  final String userId;
  final String texto;
  final DateTime data;
  final bool lida;

  Notificacao({
    required this.id,
    required this.userId,
    required this.texto,
    required this.data,
    this.lida = false,
  });

  factory Notificacao.fromMap(String id, Map<String, dynamic> map) {
    return Notificacao(
      id: id,
      userId: map['userId'],
      texto: map['texto'],
      data: (map['data'] as Timestamp).toDate(),
      lida: map['lida'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'texto': texto,
      'data': data,
      'lida': lida,
    };
  }
}