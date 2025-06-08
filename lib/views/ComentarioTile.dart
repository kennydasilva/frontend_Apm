/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version3_firebase/models/Comentario.dart';
import 'package:version3_firebase/models/denucias.dart';
import 'package:version3_firebase/temas/App_cores.dart';
import 'package:version3_firebase/viewmodels/ComentarioViewModel.dart';
import 'package:version3_firebase/viewmodels/NotificacaoViewModel.dart';
import 'package:version3_firebase/viewmodels/UserDataViewModel.dart';


class ComentariosPage extends StatelessWidget {
  final Denuncia denuncia;
  final ComentarioViewModel comentarioVM;
  final NotificacaoViewModel  notificacaoVM;

  ComentariosPage({
    required this.denuncia,
    required this.comentarioVM,
    required this.notificacaoVM,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final userData = Provider.of<UserDataViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.gradient4,
        title: Text(
            'Comentários',
             style: TextStyle(
               color: Cores.white,
             ),
        ),
        iconTheme: IconThemeData(
          color: Cores.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Comentario>>(
              stream: comentarioVM.getComentarios(denuncia.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final comentarios = snapshot.data!;
                if (comentarios.isEmpty) {
                  return Center(child: Text('Seja o primeiro a comentar!'));
                }
                return ListView(
                  children: comentarios.map((c) => ComentarioTile(denuncia: denuncia, comentario: c, comentarioVM: comentarioVM,notificacaoVM: notificacaoVM,)).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Comentar...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Cores.gradient4),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      comentarioVM.adicionarComentario(denuncia, controller.text, userData,notificacaoVM);
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class ComentarioTile extends StatelessWidget {
  final Denuncia denuncia;
  final Comentario comentario;
  final ComentarioViewModel comentarioVM;
  final NotificacaoViewModel  notificacaoVM;

  ComentarioTile({
    required this.denuncia,
    required this.comentario,
    required this.comentarioVM,
    required this.notificacaoVM,
  });

  @override
  Widget build(BuildContext context) {
    final respostaController = TextEditingController();
    final userData = Provider.of<UserDataViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.white, size: 18),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: '${comentario.autorNome} ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: comentario.texto,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  StreamBuilder<List<Comentario>>(
                    stream: comentarioVM.getRespostas(denuncia.id, comentario.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return SizedBox();
                      final respostas = snapshot.data!;
                      return Column(
                        children: respostas.map((r) => Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey[300],
                                child: Icon(Icons.person, color: Colors.white, size: 14),
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(7),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black87, fontSize: 13),
                                      children: [
                                        TextSpan(
                                          text: '${r.autorNome} ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: r.texto,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: respostaController,
                          decoration: InputDecoration(
                            hintText: 'Responder...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.reply, size: 18, color: Colors.blue),
                        onPressed: () {
                          if (respostaController.text.isNotEmpty) {
                            comentarioVM.responderComentario(denuncia, comentario, respostaController.text, userData,notificacaoVM);
                            respostaController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version3_firebase/models/Comentario.dart';
import 'package:version3_firebase/models/denucias.dart';
import 'package:version3_firebase/temas/App_cores.dart';
import 'package:version3_firebase/viewmodels/ComentarioViewModel.dart';
import 'package:version3_firebase/viewmodels/NotificacaoViewModel.dart';
import 'package:version3_firebase/viewmodels/UserDataViewModel.dart';

class ComentariosPage extends StatefulWidget {
  final Denuncia denuncia;
  final ComentarioViewModel comentarioVM;
  final NotificacaoViewModel notificacaoVM;
  final String? comentarioIdDestacado;

  ComentariosPage({
    required this.denuncia,
    required this.comentarioVM,
    required this.notificacaoVM,
    this.comentarioIdDestacado,
  });

  @override
  State<ComentariosPage> createState() => _ComentariosPageState();
}

class _ComentariosPageState extends State<ComentariosPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  void scrollToComment(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        index * 90.0, // ajuste conforme altura média do item
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.gradient4,
        title: Text(
          'Comentários',
          style: TextStyle(
            color: Cores.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Cores.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Comentario>>(
              stream: widget.comentarioVM.getComentarios(widget.denuncia.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final comentarios = snapshot.data!;
                if (comentarios.isEmpty) {
                  return Center(child: Text('Seja o primeiro a comentar!'));
                }

                // Rola até o comentário destacado, se houver
                if (widget.comentarioIdDestacado != null) {
                  final index = comentarios.indexWhere((c) => c.id == widget.comentarioIdDestacado);
                  if (index != -1) {
                    scrollToComment(index);
                  }
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: comentarios.length,
                  itemBuilder: (context, i) {
                    final c = comentarios[i];
                    return ComentarioTile(
                      denuncia: widget.denuncia,
                      comentario: c,
                      comentarioVM: widget.comentarioVM,
                      notificacaoVM: widget.notificacaoVM,
                      destacado: c.id == widget.comentarioIdDestacado,
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Comentar...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Cores.gradient4),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      widget.comentarioVM.adicionarComentario(
                        widget.denuncia,
                        controller.text,
                        userData,
                        widget.notificacaoVM,
                      );
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ComentarioTile extends StatelessWidget {
  final Denuncia denuncia;
  final Comentario comentario;
  final ComentarioViewModel comentarioVM;
  final NotificacaoViewModel notificacaoVM;
  final bool destacado;

  ComentarioTile({
    required this.denuncia,
    required this.comentario,
    required this.comentarioVM,
    required this.notificacaoVM,
    this.destacado = false,
  });

  @override
  Widget build(BuildContext context) {
    final respostaController = TextEditingController();
    final userData = Provider.of<UserDataViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.white, size: 18),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: destacado
                  ? BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange, width: 2),
              )
                  : BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: '${comentario.autorNome} ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: comentario.texto,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  StreamBuilder<List<Comentario>>(
                    stream: comentarioVM.getRespostas(denuncia.id, comentario.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return SizedBox();
                      final respostas = snapshot.data!;
                      return Column(
                        children: respostas.map((r) => Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey[300],
                                child: Icon(Icons.person, color: Colors.white, size: 14),
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(7),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black87, fontSize: 13),
                                      children: [
                                        TextSpan(
                                          text: '${r.autorNome} ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: r.texto,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: respostaController,
                          decoration: InputDecoration(
                            hintText: 'Responder...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.reply, size: 18, color: Colors.blue),
                        onPressed: () {
                          if (respostaController.text.isNotEmpty) {
                            comentarioVM.responderComentario(
                              denuncia,
                              comentario,
                              respostaController.text,
                              userData,
                              notificacaoVM,
                            );
                            respostaController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}