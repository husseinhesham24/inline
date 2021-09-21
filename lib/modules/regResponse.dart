class regResponse {
  final String name;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String updatedAt;
  final String createdAt;

  regResponse(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.updatedAt,
      required this.createdAt});

  factory regResponse.fromJson(Map<String, dynamic> json) {
    return regResponse(
      name: json['user']['name'].toString(),
      email: json['user']['email'].toString(),
      phoneNumber: json['user']['phone_number'].toString(),
      dateOfBirth: json['user']['date_of_birth'].toString(),
      updatedAt: json['user']['updated_at'].toString(),
      createdAt: json['user']['created_at'].toString(),
    );
  }
}