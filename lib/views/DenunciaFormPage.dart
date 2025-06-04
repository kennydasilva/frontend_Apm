import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:apm/viewmodels/DenunciaViewModel.dart';
import 'package:apm/models/denuncia_model.dart';



class DenunciaFormPage extends StatefulWidget {
  final Denuncia? denuncia;
  const DenunciaFormPage({this.denuncia, super.key});

  @override
  State<DenunciaFormPage> createState() => _DenunciaFormPageState();
}

class _DenunciaFormPageState extends State<DenunciaFormPage> {
  final tipoController = TextEditingController();
  final descController = TextEditingController();
  File? fotoFile;

  @override
  void initState() {
    super.initState();
    if (widget.denuncia != null) {
      tipoController.text = widget.denuncia!.tipoBurla;
      descController.text = widget.denuncia!.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    final denunciaVM = Provider.of<DenunciaViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.denuncia == null ? 'Nova Denúncia' : 'Editar Denúncia')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: tipoController,
              decoration: InputDecoration(labelText: 'Tipo de Burla'),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 12),
            fotoFile != null
                ? Image.file(fotoFile!, width: 100, height: 100)
                : widget.denuncia?.fotoUrl != null
                ? Image.network(widget.denuncia!.fotoUrl, width: 100, height: 100)
                : Container(),
            ElevatedButton(
              child: Text('Selecionar Foto'),
              onPressed: () async {
                final picker = ImagePicker();
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) setState(() => fotoFile = File(picked.path));
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: Text(widget.denuncia == null ? 'Criar' : 'Salvar'),
              onPressed: () async {
                try {
                if (widget.denuncia == null) {
                if (fotoFile != null) {
                print('Criando denúncia...');
                await denunciaVM.criarDenuncia(
                tipoController.text,
                descController.text,
                fotoFile!,
                );
                print('Denúncia criada com sucesso!');
                } else {
                print('Nenhuma foto selecionada.');
                }
                } else {
                print('Editando denúncia...');
                await denunciaVM.editarDenuncia(
                widget.denuncia!.id,
                tipoController.text,
                descController.text,
                novaFoto: fotoFile,
                );
                print('Denúncia editada com sucesso!');
                }
                Navigator.pop(context);
                } catch (e) {
                print('Erro ao salvar denúncia: $e');
                }
                },
            ),
          ],
        ),
      ),
    );
  }
}