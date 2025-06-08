import 'package:apm/viewModels/profile_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CriarDenunciaPage extends StatelessWidget {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profileVM = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Nova Publicação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await profileVM.criarDenuncia(
                  titulo: tituloController.text,
                  descricao: descricaoController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Publicar'),
            ),
          ],
        ),
      ),
    );
  }
}