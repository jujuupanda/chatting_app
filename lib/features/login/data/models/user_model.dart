import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.image,
    required super.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final email = json["email"];
    final image = json["image"];
    final phone = json["phone"];

    final userModel = UserModel(
      id: id,
      email: email,
      image: image,
      phone: phone,
    );
    return userModel;
  }
}

