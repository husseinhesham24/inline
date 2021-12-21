import 'dart:convert';

class Service {
  final int id;
  final String name;
  final String cost;

  Service({
    required this.id,
    required this.name,
    required this.cost,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      cost:json['cost']
    );
  }
  static Map<String, dynamic> toMap(Service service) => {
        'id': service.id,
        'name': service.name,
        'cost': service.cost
      };

  static String encode(List<Service> service) => json.encode(
        service
            .map<Map<String, dynamic>>((service) => Service.toMap(service))
            .toList(),
      );

  static List<Service> decode(String service) =>
      (json.decode(service) as List<dynamic>)
          .map<Service>((item) => Service.fromJson(item))
          .toList();
}
