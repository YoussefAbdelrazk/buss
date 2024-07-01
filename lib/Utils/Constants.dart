const List<String> egyptianCities = [
  "Cairo",
  "Alexandria",
  "Giza",
  "Shubra El-Kheima",
  'Hurghada',
  'Sharm El Sheikh',
  "Port Said",
  "Suez",
  "Luxor",
  "Al-Mansura",
  "Assiut",
  "Sohag",
  "Al-Minya",
  "Qena",
  "Aswan",
  "Fayoum",
  "Beni-Suef",

  // ... Include other Egyptian cities
];
// Server
const String linkServerName = 'http://localhost/busapp';
const String linkImageRoot = 'http://localhost/busapp/upload';

//Auth
const String linkLoginName = '$linkServerName/UsersAuth.php';
const String linkRegisterName = '$linkServerName/UsersRegister.php';

//Data
const String linkUserPage = '$linkServerName/GetUser.php';
const String linkCompaniesName = '$linkServerName/GetBusCompanies.php';
const String linkBusInfoName = '$linkServerName/GetBusinfo.php';
const String linkAddPaymentName = '$linkServerName/AddPayment.php';
const String linkAddBookingName = '$linkServerName/AddBooking.php';
const String linkGetBookings = '$linkServerName/GetBookingHistory.php';
