
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:version3_firebase/auxiliar/teste.dart';
import 'package:version3_firebase/models/denucias.dart';
import 'package:version3_firebase/temas/App_cores.dart';
import 'package:version3_firebase/viewmodels/ComentarioViewModel.dart';
import 'package:version3_firebase/viewmodels/FeedViewModel.dart';
import 'package:version3_firebase/viewmodels/NotificacaoViewModel.dart';
import 'package:version3_firebase/viewmodels/UserDataViewModel.dart';
import 'package:version3_firebase/viewmodels/auth_viewmodel.dart';
import 'package:version3_firebase/views/ComentarioTile.dart';



class FeedPage extends StatefulWidget {
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  bool showSearch = false;
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final feedVM = Provider.of<FeedViewModel>(context);
    final comentarioVM = ComentarioViewModel();
    final userData = Provider.of<UserDataViewModel>(context, listen: false);
    final notificacao= Provider.of<NotificacaoViewModel>(context);


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: showSearch
                ? TextField(
              controller: searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Pesquisar denúncias...',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {});
              },
            )
                : Text(
              "Denúncias de Burladores",
              style: TextStyle(
                color: Cores.gradient4,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
            centerTitle: true,
            floating: true,
            actions: [
              CircleButton(
                icon: showSearch ? Icons.close : Icons.search ,

                iconSize: 30.0,
                onPressed: () {
                  setState(() {
                    showSearch = !showSearch;
                    if (!showSearch) searchController.clear();
                  });
                },
              ),

              IconButton(
                icon: Icon(Icons.logout, color: Cores.gradient4),
                tooltip: 'Sair',
                onPressed: () async {
                  final authVM = Provider.of<AuthViewModel>(context, listen: false);
                  final userData = Provider.of<UserDataViewModel>(context, listen: false);
                  await authVM.logout(userData);
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
          SliverFillRemaining(
            child: StreamBuilder<List<Denuncia>>(
              stream: feedVM.getFeed(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                var posts = snapshot.data!;


                if (showSearch && searchController.text.isNotEmpty) {
                  posts = posts
                      .where((p) =>
                  p.titulo
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()) ||
                      p.descricao
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase()))
                      .toList();
                }

                if (posts.isEmpty)
                  return Center(child: Text('Nenhuma publicação.'));

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: posts.length,
                  itemBuilder: (context, i) {
                    final post = posts[i];
                    return PostContainerCustom(
                      denuncia: post,
                      comentarioVM: comentarioVM,
                      userData: userData,
                        feedVM:feedVM,
                      notificacaoViewModel: notificacao,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home ,color: Cores.gradient4,), label: 'Feed' ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications, color: Cores.gradient4,), label: 'Notificações'),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: Cores.gradient4,), label: 'Perfil'),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/notificacoes');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/perfil');
          }
        },
      ),
    );
  }
}






class PostContainerCustom extends StatelessWidget {
  final Denuncia denuncia;
  final ComentarioViewModel comentarioVM;
  final UserDataViewModel userData;
  final FeedViewModel feedVM;
  final NotificacaoViewModel notificacaoViewModel;

  const PostContainerCustom({
    Key? key,
    required this.denuncia,
    required this.comentarioVM,
    required this.userData,
    required this.feedVM,
    required this.notificacaoViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Row(
              children: [
                ProfileAvatar(imageUrl: ""),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        denuncia.autorNome,
                        style: const TextStyle(fontWeight: FontWeight.w600,

                        ),
                      ),
                      Text(
                        '${denuncia.data.day}/${denuncia.data.month}/${denuncia.data.year}',
                        style: TextStyle(
                          color: Cores.gradient4,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => print('Mais opções'),
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
            const SizedBox(height: 4.0),

            Text(denuncia.titulo, style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4.0),
            Text(denuncia.descricao),

            if (denuncia.imagemUrl != null && denuncia.imagemUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.file(File(denuncia.imagemUrl!), width: double.infinity, fit: BoxFit.cover),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [

                  _PostButton(
                    icon: Icon(Icons.comment, color: Cores.gradient4, size: 20.0),
                    label: 'Comentar' ,

                    onTap: () {


                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ComentariosPage(
                              denuncia: denuncia,
                              comentarioVM: comentarioVM,
                              notificacaoVM: notificacaoViewModel,
                            ),
                          ),
                        );

                    },
                  ),
                  _PostButton(
                    icon: Icon(Icons.share, color: Cores.gradient4, size: 20.0),
                    label: 'Partilhar',
                    onTap: () async {

                      await feedVM.compartilharPost(denuncia, userData.uid, userData.nome);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Compartilhamento não implementado')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final void Function() onTap;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(
                  label,
                  style: TextStyle(color: Cores.gradient4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


