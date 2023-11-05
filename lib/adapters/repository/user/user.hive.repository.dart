import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:testemundowap/domain/model/user.model.dart';
import 'package:testemundowap/core/helpers/repository.helper.dart';
import 'package:testemundowap/domain/entity/user.entity.dart';
import 'package:testemundowap/domain/repositorys/user/i.user.repositor.dart';

class UserGetStorageRepository implements IUserRepository {
  static UserGetStorageRepository? _instance;
  UserGetStorageRepository._();
  static UserGetStorageRepository get instance =>
      _instance ??= UserGetStorageRepository._();

  static final box = Hive.openBox<String>(RepositoryHelper.userBucketName);

  @override
  Future<User?> getUser() async {
    final userString = (await box).get(RepositoryHelper.userKey);
    if (userString != null) {
      return UserModel.fromJsonToEntity(json.decode(userString));
    }
    return null;
  }

  @override
  Future<User?> setUser(User user) async {
    try {
      await (await box)
          .put(RepositoryHelper.userKey, json.encode(UserModel.toJson(user)));
      return user;
    } on Exception {
      return null;
    }
  }
}
