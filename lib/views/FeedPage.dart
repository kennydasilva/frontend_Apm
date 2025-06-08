import 'dart:io';

import 'package:apm/models/denuncia_model.dart';
import 'package:apm/viewModels/comentario_viewModel.dart';
import 'package:apm/viewModels/feed_viewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/theme/App_cores.dart';
import '../features/widgets/circularButton.dart';
import '../features/widgets/profileAvatar.dart';
import '../viewModels/auth_viewModel.dart';
import '../viewModels/notificacao_viewModel.dart';
import '../viewModels/userData_viewModel.dart';
import 'Comentario.dart';

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
    final notificacao = Provider.of<NotificacaoViewModel>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Cores.gradient4,
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
              "Publicações recentes",
              style: TextStyle(
                color: Cores.whiteColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
            centerTitle: false,
            floating: true,
            actions: [
              CircleButton(
                icon: showSearch ? Icons.close : Icons.search,
                iconSize: 20.0,
                onPressed: () {
                  setState(() {
                    showSearch = !showSearch;
                    if (!showSearch) searchController.clear();
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.logout, color: Cores.whiteColor),
                tooltip: 'Sair',
                onPressed: () async {
                  final authVM =
                  Provider.of<AuthViewModel>(context, listen: false);
                  final userData =
                  Provider.of<UserDataViewModel>(context, listen: false);
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
                      feedVM: feedVM,
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
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Cores.gradient4,
              ),
              label: 'Feed'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                color: Cores.gradient4,
              ),
              label: 'Notificações'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Cores.gradient4,
              ),
              label: 'Perfil'),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileAvatar(userName: denuncia.autorNome),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        denuncia.autorNome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
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
            const SizedBox(height: 8.0),
            Text(
              denuncia.titulo,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              denuncia.descricao,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
            if (denuncia.imagemUrl != null && denuncia.imagemUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(denuncia.imagemUrl!),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _PostButton(
                    icon: Icon(Icons.comment, color: Cores.gradient4, size: 20.0),
                    label: 'Comentar',
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
                      await feedVM.compartilharPost(
                          denuncia, userData.uid, userData.nome);
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
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[100],
            ),
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 6.0),
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
