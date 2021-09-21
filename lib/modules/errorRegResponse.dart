class errorRegResponse {
  final String? errorName;
  final String? errorEmail;
  final String? errorPassword;
  final String? errorPhoneNumber;
  final String? errorDateOfBirth;
  

  errorRegResponse(
      {
      required this.errorName,
      required this.errorEmail,
      required this.errorPassword,
      required this.errorPhoneNumber,
      required this.errorDateOfBirth});

  factory errorRegResponse.fromJson(Map<String, dynamic> json) {
    return errorRegResponse(
      errorName: json['errors']['name'].toString(),
      errorEmail: json['errors']['email'].toString(),
      errorPassword: json['errors']['password'].toString(),
      errorPhoneNumber: json['errors']['phone_number'].toString(),
      errorDateOfBirth: json['errors']['date_of_birth'].toString(),
    );
  }
}