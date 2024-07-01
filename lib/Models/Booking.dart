// ignore_for_file: public_member_api_docs, sort_constructors_first
class Booking {
  final int id;
  final int busInfoId;
  final String companyName;
  final String companyLogoUrl;

  final int numberOfSeats;
  final DateTime bookingDate;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String status;
  final String fromCity;
  final String toCity;

  Booking({
    required this.id,
    required this.busInfoId,
    required this.companyName,
    required this.companyLogoUrl,
    required this.numberOfSeats,
    required this.bookingDate,
    required this.departureTime,
    required this.arrivalTime,
    required this.status,
    required this.fromCity,
    required this.toCity,
  });

  static Booking fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int,
      busInfoId: json['bus_info_id'] as int,
      companyName: json['name'],
      companyLogoUrl: json['logo_url'],
      numberOfSeats: json['number_of_seats'] as int,
      bookingDate: DateTime.parse(
          json['booking_date']), // Assuming date is in string format
      status: json['status'] as String,
      fromCity: json['origin'] as String,
      toCity: json['destination'] as String,
      departureTime: DateTime.parse(json['departure_time']),
      arrivalTime: DateTime.parse(
        json['arrival_time'],
      ),
    );
  }
}
