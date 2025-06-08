import 'package:apmt/viewModels/auth_viewModel.dart';
import 'package:apmt/viewModels/denunciaViewModel.dart';
import 'package:apmt/views/Login.dart';
import 'package:apmt/views/denuncia_ListPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        //ChangeNotifierProvider(create: (_) => DenunciaViewModel()),
        ChangeNotifierProvider(create: (_) => FeedViewModel()),
        //ChangeNotifierProvider(create: (_) => ComentarioViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => UserDataViewModel()),
        ChangeNotifierProvider(create: (_) => DenunciaViewModel()),
        ChangeNotifierProvider(create: (_) => NotificacaoViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (_) => LoginPage(),
          //'/denucias': (_) => DenunciaListPage(),
          //'/home': (_) => DenunciaListPage(),
          'feed': (_) => FeedPage(),
          '/perfil': (context) => ProfilePage(),
          '/criar_denuncia': (_) => DenunciaFormPage(),
          '/notificacoes': (context) => NotificacoesPage(),

        },
      ),
    );
  }
}