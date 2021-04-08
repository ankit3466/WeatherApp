class LocationException implements Exception {}

class ServiceException extends LocationException {
  final String message;
  ServiceException(this.message);
  @override
  String toString() {
    return "$message";
  }
}

class PermissionDenied extends LocationException {
  final String message;
  PermissionDenied(this.message);
  @override
  String toString() {
    return "$message";
  }
}

class MobilePermissionException extends LocationException {
  final String message;
  MobilePermissionException(this.message);
  @override
  String toString() {
    return "$message";
  }
}

class InternetException extends LocationException {
  final String message;
  InternetException(this.message);
  @override
  String toString() {
    return "$message";
  }
}
