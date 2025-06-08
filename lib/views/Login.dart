import 'package:apm/features/widgets/buttao.dart';
import 'package:apm/features/widgets/campo.dart';
import 'package:apm/viewModels/auth_viewModel.dart';
import 'package:apm/viewModels/userData_viewModel.dart';
import 'package:apm/view/Cadastrar.dart';
import 'package:apm/view/FeedPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
    final userData = Provider.of<UserDataViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('SIDPA', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color:  Color.fromRGBO(92, 198, 186, 1.0))),
            const SizedBox(height: 30),
            Campos(hintText: "Email", controller: emailController),
            const SizedBox(height: 15),
            Campos(hintText: "Password", controller: passwordController, isTextoOculto: true),
            const SizedBox(height: 20),
            Buttao(
              TextoButtao: 'Login',
              onTap: () async {
                await authVM.login(emailController.text, passwordController.text,userData);
                if (authVM.currentUser != null) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FeedPage()));
                }
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              child: const Text('Não tem conta? Cadastrar-se', style: TextStyle(color: Color.fromRGBO(92, 198, 186, 1.0))),
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