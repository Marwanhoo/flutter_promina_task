class UserModel {
  String id;
  String name;
  String email;
  String token;


  UserModel({required this.id, required this.name, required this.email, required this.token,});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'].toString(),
      name: json['user']['name'],
      email: json['user']['email'],
      token: json['token'],
    );
  }
}

