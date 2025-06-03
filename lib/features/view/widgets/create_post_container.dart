import 'package:apm/features/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:apm/models/models.dart';
class CreatePostContainer extends StatelessWidget {

  final User currentUser;

  const CreatePostContainer({
    Key? key,
    required this.currentUser
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              ProfileAvatar(
                  imageUrl: currentUser.imageUrl
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'What\'s on your mind?'
                  ),
                )
              ),
            ],
          ),
          const Divider(
            height: 10.0,
            thickness: 0.5,
          ),
          Container(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () => print('Live'),
                    icon: const Icon(
                      Icons.videocam,
                      color: Colors.red,
                    ),
                ),
                Text("Live"),
                //FlatButton.icon(
                // onPressed: () =>print('Live'),
                // icon const Icon(Icons.videocam,
                // color: Colors.red,
                // label: Text('Live'),
                // ),
                const VerticalDivider(width: 8.0,),
                IconButton(
                    onPressed: () => print('Photo'),
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.green,
                    ),
                ),
                Text('Photo'),
                //FlatButton.icon(
                // onPressed: () =>print('Live'),
                // icon const Icon(Icons.videocam,
                // color: Colors.red,
                // label: Text('Live'),
                // ),
                const VerticalDivider(width: 8.0,),
                IconButton(
                    onPressed: () => print('Room'),
                    icon: const Icon(
                      Icons.video_call,
                      color: Colors.purpleAccent,
                    )
                ),
                Text('Room'),
                //FlatButton.icon(
                // onPressed: () =>print('Live'),
                // icon const Icon(Icons.videocam,
                // color: Colors.red,
                // label: Text('Live'),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
