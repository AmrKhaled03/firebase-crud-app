class UserModel {
  String id;
  String name;
  String email;
  String phone;
  bool deleted;

  UserModel({
    this.id = '',
    required this.name,
    required this.email,
    required this.phone,
    this.deleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'deleted': deleted,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      deleted: json['deleted'] ?? false,
    );
  }
}
