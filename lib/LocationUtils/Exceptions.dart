class LocationException implements Exception {}

class ServiceException extends LocationException {
  final String message;
  ServiceException(this.message);
  @override
  String toString() {
    if (message == null) return "Service is not enabled.";
    return "$message";
  }
}

class PermissionDenied extends LocationException {
  final String message;
  PermissionDenied(this.message);
  @override
  String toString() {
    if (message == null) return "Service is not enabled.";
    return "$message";
  }
}

class PermissionDeniedPermanently extends LocationException {
  final String message;
  PermissionDeniedPermanently(this.message);
  @override
  String toString() {
    if (message == null) return "Service is not enabled.";
    return "$message";
  }
}
