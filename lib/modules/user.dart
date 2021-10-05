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
}
