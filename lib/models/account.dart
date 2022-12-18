class User {
  int? id;
  String? userName;
  String? password;
  String? fullName;
  int? isRole;
  User({
    this.id,
    this.userName,
    this.password,
    this.fullName,
    this.isRole,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['ID']),
      userName: json['username'],
      password: json['password'],
      fullName: json['name'],
      isRole: int.parse(json['role']),
    );
  }
}
