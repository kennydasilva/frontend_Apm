import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModels/userData_viewModel.dart';
import '../features/theme/App_cores.dart';

class PerfilEditarPage extends StatefulWidget {
  const PerfilEditarPage({super.key});

  @override
  State<PerfilEditarPage> createState() => _PerfilEditarPageState();
}

class _PerfilEditarPageState extends State<PerfilEditarPage> {
  late TextEditingController nomeController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    final userData = Provider.of<UserDataViewModel>(context, listen: false);
    nomeController = TextEditingController(text: userData.nome);
    emailController = TextEditingController(text: userData.email);
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil', style: TextStyle(color: Cores.whiteColor)),
        backgroundColor: Cores.gradient4,
        iconTheme: IconThemeData(color: Cores.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Cores.gradient4,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Salvar', style: TextStyle(color: Cores.whiteColor)),
              onPressed: () async {
                await userData.atualizarDadosUsuario(
                  nomeController.text.trim(),
                  emailController.text.trim(),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Dados atualizados com sucesso!')),
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
