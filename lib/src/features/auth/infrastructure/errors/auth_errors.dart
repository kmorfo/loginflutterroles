class ConnectionTimeout implements Exception {}

class InvalidToken implements Exception {}

class WrongCredentials implements Exception {}

class CustomError implements Exception {
  final String message;

//final int errorCore;
  CustomError(this.message);
}
