import 'package:apm/features/view/widgets/Buttao.dart' show Buttao;
import 'package:apm/views/DenunciaListPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'register_page.dart';
import 'package:apm/features/view/widgets/Campo.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login.', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Campos(hintText: "Email", controller: emailController),
            const SizedBox(height: 15),
            Campos(hintText: "Password", controller: passwordController, isTextoOculto: true),
            const SizedBox(height: 20),
            Buttao(
              TextoButtao: 'Login',
              onTap: () async {
                await authVM.login(emailController.text, passwordController.text);
                if (authVM.currentUser != null) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DenunciaListPage()));
                }
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              child: const Text('Não tem conta? Cadastrar-se'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}