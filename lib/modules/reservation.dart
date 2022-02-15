import 'dart:convert';

class Reservation {
  final String branch_name, service_name, current_turn, queue, my_turn;
  // final String email;
  // final String address;
  // final String phone;
  // final double lat;
  // final double lon;
  // final DateTime startTime;
  // final DateTime closeTime;
  // final String providerId;

  Reservation({
    required this.branch_name,
    required this.service_name,
    required this.current_turn,
    required this.queue,
    required this.my_turn,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      branch_name: json['branch_name'],
      service_name: json['service_name'],
      current_turn: json['current_turn'],
      queue: json['queue'],
      my_turn: json['my_turn'],
    );
  }
  static Map<String, dynamic> toMap(Reservation reservation) => {
        'branch_name': reservation.branch_name,
        'service_name': reservation.service_name,
        'current_turn': reservation.current_turn,
        'queue': reservation.queue,
        'my_turn': reservation.my_turn,
      };

  static String encode(List<Reservation> reservation) => json.encode(
        reservation
            .map<Map<String, dynamic>>(
                (reservation) => Reservation.toMap(reservation))
            .toList(),
      );

  static List<Reservation> decode(String reservation) =>
      (json.decode(reservation) as List<dynamic>)
          .map<Reservation>((item) => Reservation.fromJson(item))
          .toList();
}
