// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class BusInfo {
  final int businfoid;
  final String companyName;
  final String origin;
  final String companyLogo;
  final String destination;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int availableSeats;
  final double price;

  BusInfo({
    required this.businfoid,
    required this.companyName,
    required this.companyLogo,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.availableSeats,
    required this.price,
  });

  // Optional constructor to create BusInfo from a Map (assuming API response)
  factory BusInfo.fromJson(Map<String, dynamic> json) {
    return BusInfo(
      companyLogo: json['logo_url'],
      businfoid: json['id'] as int,
      companyName: json['name'] as String,
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      departureTime: DateTime.parse(json['departure_time'] as String),
      arrivalTime: DateTime.parse(json['arrival_time'] as String),
      availableSeats: json['available_seats'] as int,
      price: double.parse(json['fare'] as String),
    );
  }

  String get formattedDepartureTime {
    final formatter = DateFormat('yyyy-MM-dd HH:mm'); // Customize format here
    return formatter.format(departureTime);
  }

  String get formattedArrivalTime {
    final formatter = DateFormat('yyyy-MM-dd HH:mm'); // Customize format here
    return formatter.format(arrivalTime);
  }
}
