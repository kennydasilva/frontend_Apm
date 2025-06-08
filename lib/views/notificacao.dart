import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/theme/App_cores.dart';
import '../models/denuncia_model.dart';
import '../models/notificacao_model.dart';
import '../viewModels/comentario_viewModel.dart';
import '../viewModels/notificacao_viewModel.dart';
import '../viewModels/userData_viewModel.dart';
import 'Comentario.dart';

class NotificacoesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificacaoVM = Provider.of<NotificacaoViewModel>(context, listen: false);
    final userData = Provider.of<UserDataViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.gradient4,
        title: Text('Notificações', style: TextStyle(color: Cores.whiteColor)),
        iconTheme: IconThemeData(color: Cores.whiteColor),
      ),
      body: StreamBuilder<List<Notificacao>>(
        stream: notificacaoVM.getNotificacoes(userData.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Cores.gradient4));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma notificação.', style: TextStyle(color: Colors.grey)));
          }

          final notificacoes = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: notificacoes.length,
            itemBuilder: (context, i) {
              final n = notificacoes[i];

              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation:0.2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Icon(
                    n.lida ? Icons.notifications_none : Icons.notifications_active,
                    color: n.lida ? Colors.grey : Cores.gradient4,
                  ),
                  title: Text(
                    n.texto,
                    style: TextStyle(
                      fontWeight: n.lida ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${n.data.day.toString().padLeft(2, '0')}/${n.data.month.toString().padLeft(2, '0')}/${n.data.year}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
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
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Cores.gradient4,
        unselectedItemColor: Colors.grey[600],
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, 'feed');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/perfil');
          }
        },
      ),
    );
  }
}
