import 'package:apm/models/denuncia_model.dart';
import 'package:apm/viewModels/denunciaViewModel.dart';
import 'package:apm/view/denuncia_FormPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';





class DenunciaListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final denunciaVM = Provider.of<DenunciaViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Minhas Denúncias')),
      body: StreamBuilder<List<Denuncia>>(
        stream: denunciaVM.getDenuncias(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final denuncias = snapshot.data!;
          if (denuncias.isEmpty) return Center(child: Text('Nenhuma denúncia cadastrada.'));
          return ListView.builder(
            itemCount: denuncias.length,
            itemBuilder: (context, i) {
              final d = denuncias[i];
              return ListTile(
                leading: Image.file(File(d.imagemUrl), width: 50, height: 50, fit: BoxFit.cover),
                title: Text(d.titulo),
                subtitle: Text(d.descricao),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DenunciaFormPage(denuncia: d),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => denunciaVM.apagarDenuncia(d.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DenunciaFormPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}