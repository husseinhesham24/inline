import 'dart:convert';

class Service {
  final int branches_id;
  final int services_id;
  final String name;
  final String cost;

  Service({
    required this.branches_id,
    required this.services_id,
    required this.name,
    required this.cost,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    // print("2rf awy");
    // print(json);
    // print(json['branches_id']);
    // print(json['services_id']);
    // print(json['name']);
    // print(json['cost']);
    return Service(
      branches_id: json['branches_id'],
      services_id: json['services_id'],
      name: json['name'],
      cost: json['cost'],
    );
  }
  static Map<String, dynamic> toMap(Service service) => {
        'branches_id': service.branches_id,
        'services_id': service.services_id,
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
