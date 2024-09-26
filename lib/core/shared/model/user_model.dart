import '../entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.image,
    required super.phone,
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.information,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final email = json["email"];
    final image = json["image"];
    final phone = json["phone"];
    final firstName = json["first_name"];
    final middleName = json["middle_name"];
    final lastName = json["last_name"];
    final information = json["information"];

    final userModel = UserModel(
      id: id,
      email: email,
      image: image,
      phone: phone,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      information: information,
    );
    return userModel;
  }
}
