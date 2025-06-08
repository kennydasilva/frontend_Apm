import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version3_firebase/models/denucias.dart';
import 'package:version3_firebase/viewmodels/ProfileViewModel.dart';
import 'package:version3_firebase/viewmodels/UserDataViewModel.dart';
import 'package:version3_firebase/views/DenuciaUpdatePage.dart';



class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileVM = Provider.of<ProfileViewModel>(context);
    // final userId = profileVM.currentUserId;
    final userData = Provider.of<UserDataViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/editar_perfil');
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Denuncia>>(
        stream: profileVM.getUserPosts(userData),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final posts = snapshot.data!;
          if (posts.isEmpty) return Center(child: Text('Sem publicações.'));
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, i) {
              final post = posts[i];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(post.titulo),
                  subtitle: Text(post.descricao),
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.file(File(post.imagemUrl), width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditarDenunciaPage(denuncia: post),
                          ),
                        );
                      } else if (value == 'delete') {
                        profileVM.deleteDenuncia(post.id);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: 'edit', child: Text('Editar')),
                      PopupMenuItem(value: 'delete', child: Text('Apagar')),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/criar_denuncia');
        },
        child: Icon(Icons.add),
        tooltip: 'Nova Denúncia',
      ),
    );
  }
}