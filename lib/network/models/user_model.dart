class UserModel {
  late String id;
  late String email;

  UserModel({
    required this.id,
    required this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
  }
}
