import 'package:flutter/material.dart';
import 'package:projecto_final/core/theme/App_cores.dart';
import 'package:projecto_final/features/view/widgets/Buttao.dart';
import 'package:projecto_final/features/view/widgets/Campo.dart';



class Cadastrar extends StatefulWidget {
  const Cadastrar({super.key});

  @override
  State<Cadastrar> createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  final nomeController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController= TextEditingController();
  final formKey=GlobalKey<FormState>();

  @override
  void dispose(){
    nomeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();

    formKey.currentState!.validate();
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
                'Cadastrar-se',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Cores.gradient4,
                ),
              ),

              const SizedBox(height: 30),
              Campos(
                hintText: 'Nome',
                controller: nomeController,
              ),

              const SizedBox(height: 15),
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
                TextoButtao: 'Cadastro',
                onTap: () {},
              ),

              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                    text: 'Ja tem uma Conta? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: const [
                      TextSpan(
                        text:'Logar',
                        style: TextStyle(
                          color: Cores.gradient4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
