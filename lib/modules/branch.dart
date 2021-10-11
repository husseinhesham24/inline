import 'dart:convert';

class Branch {
  final int id;
  final String name;
  // final String email;
  // final String address;
  // final String phone;
  // final double lat;
  // final double lon;
  // final DateTime startTime;
  // final DateTime closeTime;
  // final String providerId;
  final String photo;

  Branch({
    required this.id,
    required this.name,
    // required this.lat,
    // required this.lon,
    // required this.phone,
    required this.photo,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      // lat: json['age'],
      // address: json['address'],
      // type: json['type'],
      // phone: json['phone'],
      photo: json['photo'],
    );
  }
  static Map<String, dynamic> toMap(Branch branch) => {
        'id': branch.id,
        'name': branch.name,
        // 'email': branch.email,
        // 'address': branch.address,
        // 'type': branch.type,
        // 'phone': branch.phone,
        'photo': branch.photo,
      };

  static String encode(List<Branch> branch) => json.encode(
        branch
            .map<Map<String, dynamic>>((branch) => Branch.toMap(branch))
            .toList(),
      );

  static List<Branch> decode(String branch) =>
      (json.decode(branch) as List<dynamic>)
          .map<Branch>((item) => Branch.fromJson(item))
          .toList();
}
