import 'package:apm/config/palette.dart';
import 'package:apm/core/theme/App_cores.dart';
import 'package:apm/features/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:apm/models/models.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({
    Key? key,
    required this.post
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(post: post),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  post.caption
                ),
                post.imageUrl != null
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 6.0,)
              ],
            ),
          ),
          post.imageUrl != null
              ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.asset(post.imageUrl),
              )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: _PostStatus(post: post,),
          )
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key? key,
    required this.post
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user.imageUrl),
        const SizedBox(width: 8.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  post.user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600
                  ),
              ),
              Row(
                children: [
                  Text(
                    '${post.timeAgo} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              )
            ],
          ),
        ),
        IconButton(
            onPressed: () => print('More'),
            icon: const Icon(Icons.more_horiz),
        )
      ],
    );
  }
}

class _PostStatus extends StatelessWidget {
  final Post post;

  const _PostStatus({
    Key? key,
    required this.post
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [

            const SizedBox(width: 4.0),

            Text(
              '${post.comments} Comments',
              style: TextStyle(
                  color: Colors.grey[600]
              ),
            ),

            const SizedBox(width: 8.0),
            
            Text(
              '${post.shares} Shares',
              style: TextStyle(
                  color: Colors.grey[600]
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                Icons.comment,
                color: Cores.greenColor,
                size: 20.0,
              ),
              label: 'Comentar',
              onTap: () {print("Comentar");},
            ),
            _PostButton(
              icon: Icon(
                Icons.share,
                color: Cores.gradient4,
                size: 20.0,
              ),
              label: 'Partilhar',
              onTap: () {print("Partilhar");},
            )
          ],
        )
      ],
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
    required this.onTap
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
                Text(label)
              ],
            ),
          ),
        ),
      ),
    );
  }
}



