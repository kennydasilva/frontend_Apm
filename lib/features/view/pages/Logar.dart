import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste/core/theme/App_cores.dart';
import 'package:teste/features/view/widgets/Buttao.dart';
import 'package:teste/features/view/widgets/Campo.dart';
import 'package:flutter/gestures.dart';



class Logar extends StatefulWidget {
  const Logar({super.key});

  @override
  State<Logar> createState() => _LogarState();
}

class _LogarState extends State<Logar> {
  final emailController=TextEditingController();
  final passwordController= TextEditingController();
  final formKey=GlobalKey<FormState>();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();

    formKey.currentState!.validate();
  }

  Future<void> loginUsuarioComEmailESenha() async {
    try{
      final credenciais = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      print(credenciais);
      print("Funcionou");
    } on FirebaseAuthException catch(erro) {
      print(erro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Cores.gradient4,
                ),
              ),

              const SizedBox(height: 30),

              Campos(
                hintText: "Email",
                controller: emailController,
              ),

              const SizedBox(height: 15),
              Campos(
                hintText: "Password",
                controller: passwordController,
                isTextoOculto: true,
              ),

              const SizedBox(height: 20),
              Buttao(
                TextoButtao: 'Login',
                onTap: () async {
                  await loginUsuarioComEmailESenha();
                },
              ),

              const SizedBox(height: 20),

              RichText(
                text: TextSpan(
                  text: 'Não tem conta? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Cadastrar-se',
                      style: const TextStyle(
                        color: Cores.gradient4,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed('/Cadastrar');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}