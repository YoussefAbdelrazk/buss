import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  List<int> _bookedSeats = [];

  List<int> get bookedSeats => _bookedSeats;

  void setBookedSeats(List<int> newBookedSeats) {
    _bookedSeats = newBookedSeats;
    notifyListeners(); // Notify listeners about changes
  }

  void addBookedSeat(int seatNumber) {
    if (!_bookedSeats.contains(seatNumber)) {
      _bookedSeats.add(seatNumber);
      notifyListeners();
    }
  }

  void removeBookedSeat(int seatNumber) {
    _bookedSeats.remove(seatNumber);
    notifyListeners();
  }
}
