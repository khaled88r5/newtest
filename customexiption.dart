class customException implements Exception {
  final String message;
  customException({required this.message});
  String getMessage() {
    return this.message;
  }
}
