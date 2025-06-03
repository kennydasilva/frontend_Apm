import 'package:apm/config/palette.dart';
import 'package:apm/core/theme/App_cores.dart';
import 'package:apm/data/data.dart';
import 'package:apm/features/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:apm/models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Text(
                "Denuncias de Burladores",
              style: const TextStyle(
                color: Cores.gradient4,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2
              ),
            ),
            centerTitle: true,
            floating: true,
            actions: [
              CircleButton(
                icon: Icons.search,
                iconSize: 30.0,
                onPressed: () => print('Procurar'),
              ),
            ],
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final Post post = posts[index];
                  return PostContainer(post: post);
                },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}