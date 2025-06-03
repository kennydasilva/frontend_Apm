import 'package:apm/models/models.dart';

final User currentUser = User(name: "Eddy", imageUrl: "assets/foto_1.jpg");
final List<User> onlineUsers = [
  User(name: "Jorge", imageUrl: "assets/foto_1.jpg"),
  User(name: "Pedro", imageUrl: "assets/foto_1.jpg"),
  User(name: "Laura", imageUrl: "assets/foto_1.jpg"),
  User(name: "Paulo", imageUrl: "assets/foto_1.jpg"),
  User(name: "Maria", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
  User(name: "Telma", imageUrl: "assets/foto_1.jpg"),
];

final List<Story> stories = [
  Story(
    user: onlineUsers[2],
    imageUrl: 'assets/foto_1.png',
    isViewed: true
  ),
  Story(
      user: onlineUsers[1],
      imageUrl: 'assets/foto_1.png',
      isViewed: true
  ),
  Story(
      user: onlineUsers[0],
      imageUrl: 'assets/foto_1.png',
      isViewed: true
  ),
  Story(
      user: onlineUsers[20],
      imageUrl: 'assets/foto_1.png',
      isViewed: true
  ),
  Story(
      user: onlineUsers[19],
      imageUrl: 'assets/foto_1.png',
      isViewed: true
  ),
  Story(
      user: onlineUsers[10],
      imageUrl: 'assets/foto_1.png',
      isViewed: true
  ),
  Story(
      user: onlineUsers[15],
      imageUrl: 'assets/foto_1.png',
      isViewed: true
  ),
  Story(
      user: onlineUsers[7],
      imageUrl: 'assets/foto_1.png',
      isViewed: true
  ),
  Story(
      user: onlineUsers[13],
      imageUrl: 'assets/foto_1.png',
      isViewed: true
  ),
  Story(
      user: onlineUsers[8],
      imageUrl: 'assets/foto_1.png',
      isViewed: true
  ),
  Story(
      user: onlineUsers[3],
      imageUrl: 'assets/foto_1.png',
      isViewed: true
  ),
];

final List<Post> posts = [
  Post(
    user: currentUser,
    caption: 'Este é o dono site que vende cursos falsos',
    timeAgo: '58m',
    imageUrl: 'assets/foto_1.jpg',
    likes: 3028,
    comments: 184,
    shares: 199
  ),
  Post(
      user: onlineUsers[5],
      caption: 'Este é o dono site que vende cursos falsos',
      timeAgo: '58m',
      imageUrl: 'assets/foto_1.jpg',
      likes: 100238,
      comments: 3499,
      shares: 40282
  ),
  Post(
      user: onlineUsers[4],
      caption: 'Este é o dono site que vende cursos falsos',
      timeAgo: '58m',
      imageUrl: 'assets/foto_1.jpg',
      likes: 3028,
      comments: 184,
      shares: 199
  ),
  Post(
      user: onlineUsers[6],
      caption: 'Este é o dono site que vende cursos falsos',
      timeAgo: '58m',
      imageUrl: 'assets/foto_1.jpg',
      likes: 3028,
      comments: 400,
      shares: 30
  ),
  Post(
      user: onlineUsers[2],
      caption: 'Este é o dono site que vende cursos falsos',
      timeAgo: '58m',
      imageUrl: 'assets/foto_1.jpg',
      likes: 129,
      comments: 2,
      shares: 12
  ),
  Post(
      user: onlineUsers[1],
      caption: 'Este é o dono site que vende cursos falsos',
      timeAgo: '58m',
      imageUrl: 'assets/foto_1.jpg',
      likes: 500,
      comments: 20,
      shares: 300
  ),
];