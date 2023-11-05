class LoginRequestDTO {
  final String user;
  final String password;

  LoginRequestDTO({required this.user, required this.password});

  toJson() => {
        "user": user,
        "password": password,
      };
}
