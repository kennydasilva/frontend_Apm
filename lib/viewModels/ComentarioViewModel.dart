import 'package:cloud_firestore/cloud_firestore.dart';


class ComentarioViewModel {
  final _db = FirebaseFirestore.instance;

  Stream<List<ComentarioViewModel>> getComentarios(String postId) {
    return _db
        .collection('posts')
        .doc(postId)
        .collection('comentarios')
        .orderBy('data')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ComentarioViewModel.fromMap(doc.id, doc.data()))
        .toList());
  }

  Future<void> adicionarComentario(Denuncia denuncia, String texto, UserDataViewModel userdata,NotificacaoViewModel notificacaoVM) async {
    await _db
        .collection('posts')
        .doc(denuncia.id)
        .collection('comentarios')
        .add({
      'texto': texto,
      'autorNome': userdata.nome,
      'autorUID': userdata.uid,
      'data': DateTime.now(),
    });

      String tituloDenucia=denuncia.titulo;
      String? autorNome=userdata.nome;

    if (denuncia.autorId != userdata.uid) {
      final notificacao = Notificacao(
        id: '',
        userId: denuncia.autorId,
        texto: '$autorNome comentou na sua publicação "$tituloDenucia"',
        data: DateTime.now(),
        postId: denuncia.id,
        comentarioId: null,
      );
      await notificacaoVM.adicionarNotificacao(notificacao);
    }
  }


  Future<void> responderComentario(Denuncia denucia, Comentario comentario, String texto, UserDataViewModel usedata,NotificacaoViewModel notificacaoVM) async {
    await _db
        .collection('posts')
        .doc(denucia.id)
        .collection('comentarios')
        .doc(comentario.id)
        .collection('respostas')
        .add({
      'texto': texto,
      'autorNome': usedata.nome,
      'autorUID': usedata.uid,
      'data': DateTime.now(),
    });

    String? autorNome=usedata.nome;
    String textoComentarioOriginal= comentario.texto;
    String autorUid=comentario.autorUID;

    if ( autorUid != usedata.uid) {
      final notificacao = Notificacao(
        id: '',
        userId: comentario.autorUID,
        texto: '$autorNome respondeu ao seu comentário: "$textoComentarioOriginal"',
        data: DateTime.now(),
        postId: denucia.id,
        comentarioId: comentario.id,
      );
      await notificacaoVM.adicionarNotificacao(notificacao);
    }
  }

  Stream<List<Comentario>> getRespostas(String postId, String comentarioId) {
    return _db
        .collection('posts')
        .doc(postId)
        .collection('comentarios')
        .doc(comentarioId)
        .collection('respostas')
        .orderBy('data')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Comentario.fromMap(doc.id, doc.data()))
        .toList());
  }
}