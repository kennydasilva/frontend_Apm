import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version3_firebase/models/Notificacao.dart';
import 'package:version3_firebase/models/denucias.dart';
import 'package:version3_firebase/viewmodels/ComentarioViewModel.dart';

import 'package:version3_firebase/viewmodels/NotificacaoViewModel.dart';
import 'package:version3_firebase/viewmodels/UserDataViewModel.dart';
import 'package:version3_firebase/views/ComentarioTile.dart';

class NotificacoesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificacaoVM = Provider.of<NotificacaoViewModel>(context, listen: false);
    final userData = Provider.of<UserDataViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notificações'),
      ),
      body: StreamBuilder<List<Notificacao>>(
        stream: notificacaoVM.getNotificacoes(userData.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final notificacoes = snapshot.data!;
          if (notificacoes.isEmpty) return Center(child: Text('Nenhuma notificação.'));
          return ListView.builder(
            itemCount: notificacoes.length,
            itemBuilder: (context, i) {
              final n = notificacoes[i];
              return ListTile(
                leading: Icon(
                  n.lida ? Icons.notifications_none : Icons.notifications,
                  color: n.lida ? Colors.grey : Colors.blue,
                ),
                title: Text(n.texto),
                subtitle: Text('${n.data.day}/${n.data.month}/${n.data.year}'),

                onTap: () async {
                  notificacaoVM.marcarComoLida(n.id);

                  if (n.postId != null) {

                    final doc = await FirebaseFirestore.instance.collection('Denuncia').doc(n.postId).get();
                    if (doc.exists) {
                      final denuncia = Denuncia.fromMap(doc.id, doc.data()!);
                      final comentarioVM = Provider.of<ComentarioViewModel>(context, listen: false);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ComentariosPage(
                            denuncia: denuncia,
                            comentarioVM: comentarioVM,
                            notificacaoVM: notificacaoVM,
                            comentarioIdDestacado: n.comentarioId,
                          ),
                        ),
                      );
                    }
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}