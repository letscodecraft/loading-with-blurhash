class PostModel {
  final String id;
  final String picture;
  final String pictureHash;
  final String caption;
  final UserModel user;

  PostModel({
    required this.id,
    required this.picture,
    required this.pictureHash,
    required this.caption,
    required this.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      picture: json['picture'],
      pictureHash: json['pictureHash'],
      caption: json['caption'],
      user: UserModel.fromJson(json['user']),
    );
  }
}

class UserModel {
  final String name;
  final String image;

  UserModel({required this.name, required this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      image: json['image'],
    );
  }
}
