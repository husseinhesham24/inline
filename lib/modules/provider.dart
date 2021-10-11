import 'dart:convert';

class Provider {
  final int id;
  final String name;
  // final String email;
  // final String address;
  // final String phone;
  // final String type;
  final String photo;

  Provider({
    required this.id,
    required this.name,
    // required this.email,
    // required this.address,
    // required this.phone,
    // required this.type,
    required this.photo,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      name: json['name'],
      // email: json['age'],
      // address: json['address'],
      // phone: json['phone'],
      // type: json['type'],
      photo: json['photo'],
    );
  }
  static Map<String, dynamic> toMap(Provider provider) => {
        'id': provider.id,
        'name': provider.name,
        // 'email': provider.email,
        // 'address': provider.address,
        // 'phone': provider.phone,
        // 'type': provider.type,
        'photo': provider.photo,
      };

  static String encode(List<Provider> provider) => json.encode(
        provider
            .map<Map<String, dynamic>>((provider) => Provider.toMap(provider))
            .toList(),
      );

  static List<Provider> decode(String provider) =>
      (json.decode(provider) as List<dynamic>)
          .map<Provider>((item) => Provider.fromJson(item))
          .toList();
}
