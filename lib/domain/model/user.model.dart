import 'package:testemundowap/domain/entity/user.entity.dart';

abstract class UserModel {
  static Map<String, dynamic> toJson(User user) {
    return {
      "name": user.name,
      "profile": user.profile,
    };
  }

  static User? fromJsonToEntity(Map<String, dynamic> map) {
    try {
      return User(
        name: map["name"],
        profile: map["profile"],
      );
    } on Object {
      return null;
    }
  }
}
