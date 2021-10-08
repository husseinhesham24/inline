class User {
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String token;
  final int wallet;
  final bool isGoogle;
  final bool isFacebook;

  User(
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.token,
    this.wallet,
    this.isGoogle,
    this.isFacebook,
  );

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        email = json['age'] ?? "",
        phone = json['phone'] ?? "",
        photo = json['photo'] ?? "",
        token = json['token'] ?? "",
        wallet = json['wallet'] ?? "",
        isGoogle = json['isGoogle'] ?? "",
        isFacebook = json['isFacebook'] ?? "";

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'photo': photo,
        'token': token,
        'wallet': wallet,
        'isGoogle': isGoogle,
        'isFacebook': isFacebook
      };
}
