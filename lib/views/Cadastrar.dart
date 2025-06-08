import 'package:apm/features/widgets/buttao.dart';
import 'package:apm/features/widgets/campo.dart';
import 'package:apm/viewModels/auth_viewModel.dart';
import 'package:apm/view/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nomeController = TextEditingController();

  RegisterPage({super.key});

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
            const Text('SIDPA', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color:  Color.fromRGBO(92, 198, 186, 1.0))),
            const SizedBox(height: 30),
            Campos(hintText: "Email", controller: emailController),
            const SizedBox(height: 15),
            Campos(hintText: "nome", controller: nomeController),
            const SizedBox(height: 15),
            Campos(hintText: "Password", controller: passwordController, isTextoOculto: true),
            const SizedBox(height: 20),
            Buttao(
              TextoButtao: 'Cadastro',
              onTap: () async {
                await authVM.register(emailController.text, passwordController.text,nomeController.text);
                if (authVM.currentUser != null) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
                }
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              child: const Text('Já tem uma Conta? Logar',   style: TextStyle(color: Color.fromRGBO(92, 198, 186, 1.0)),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}