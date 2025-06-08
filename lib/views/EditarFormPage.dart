import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/denuncia_model.dart';
import '../viewModels/denunciaViewModel.dart';
import '../features/theme/App_cores.dart';

class EditarDenunciaPage extends StatefulWidget {
  final Denuncia denuncia;
  const EditarDenunciaPage({required this.denuncia, super.key});

  @override
  State<EditarDenunciaPage> createState() => _EditarDenunciaPageState();
}

class _EditarDenunciaPageState extends State<EditarDenunciaPage> {
  late TextEditingController manualTituloController;
  late TextEditingController descController;
  File? fotoFile;

  final List<String> tiposDenuncia = [
    'Roubo',
    'Assalto',
    'Burla',
    'Objecto perdido',
    'Objecto encontrado',
    'Pessoa desaparecida',
    'Pessoa encontrada',
    'Outro',
  ];

  String? tipoSelecionado;

  @override
  void initState() {
    super.initState();
    manualTituloController = TextEditingController();
    descController = TextEditingController(text: widget.denuncia.descricao);

    if (tiposDenuncia.contains(widget.denuncia.titulo)) {
      tipoSelecionado = widget.denuncia.titulo;
    } else {
      tipoSelecionado = 'Outro';
      manualTituloController.text = widget.denuncia.titulo;
    }
  }

  @override
  void dispose() {
    manualTituloController.dispose();
    descController.dispose();
    super.dispose();
  }

  bool validaCampos() {
    if (tipoSelecionado == null) {
      _mostrarSnack('Por favor, selecione um tipo de post.');
      return false;
    }
    if (tipoSelecionado == 'Outro' && manualTituloController.text.trim().isEmpty) {
      _mostrarSnack('Por favor, preencha o título manualmente.');
      return false;
    }
    if (descController.text.trim().isEmpty) {
      _mostrarSnack('Por favor, preencha a descrição.');
      return false;
    }
    return true;
  }

  void _mostrarSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final denunciaVM = Provider.of<DenunciaViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Publicação'),
        backgroundColor: Cores.gradient4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: tipoSelecionado,
              decoration: InputDecoration(
                labelText: 'Tipo Post',
                labelStyle: TextStyle(color: Cores.gradient4),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Cores.gradient4),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Cores.gradient3, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: tiposDenuncia.map((tipo) {
                return DropdownMenuItem(
                  value: tipo,
                  child: Text(tipo),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  tipoSelecionado = val;
                  if (val != 'Outro') manualTituloController.clear();
                });
              },
            ),
            const SizedBox(height: 16),
            if (tipoSelecionado == 'Outro')
              TextField(
                controller: manualTituloController,
                decoration: InputDecoration(
                  labelText: 'Especifique o título',
                  labelStyle: TextStyle(color: Cores.gradient4),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Cores.gradient4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Cores.gradient3, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            if (tipoSelecionado == 'Outro') const SizedBox(height: 16),
            TextField(
              controller: descController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Descrição',
                labelStyle: TextStyle(color: Cores.gradient4),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Cores.gradient4),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Cores.gradient3, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (fotoFile != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  fotoFile!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            else if (widget.denuncia.imagemUrl != null && widget.denuncia.imagemUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(File(widget.denuncia.imagemUrl!),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.image_outlined,
                  size: 100,
                  color: Colors.grey[400],
                ),
              ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.photo_library, color: Cores.whiteColor),
              label: Text('Selecionar Nova Foto'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Cores.gradient4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () async {
                final picker = ImagePicker();
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() {
                    fotoFile = File(picked.path);
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Cores.gradient4,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Salvar',
                style: TextStyle(
                  color: Cores.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                if (!validaCampos()) return;

                final tituloFinal = tipoSelecionado == 'Entre outros'
                    ? manualTituloController.text.trim()
                    : tipoSelecionado!;

                await denunciaVM.editarDenuncia(
                  widget.denuncia.id,
                  tituloFinal,
                  descController.text.trim(),
                  novaFoto: fotoFile,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
