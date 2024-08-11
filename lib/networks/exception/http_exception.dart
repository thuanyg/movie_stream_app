class CustomHTTPException implements Exception {
  final dynamic message;

  CustomHTTPException(this.message);

  @override
  String toString() {
    return message;
  }
}

class BadRequestException extends CustomHTTPException {
  BadRequestException(super.message);
}

class FetchDataException extends CustomHTTPException {
  FetchDataException(super.message);
}

class UserInputException extends CustomHTTPException {
  UserInputException(super.message);
}

class InternalServerException extends CustomHTTPException {
  InternalServerException(super.message);
}

class TimeoutException extends CustomHTTPException {
  TimeoutException(super.message);
}

class ParsingException extends CustomHTTPException {
  ParsingException(super.message);
}

class UserAlreadyExistedException extends CustomHTTPException {
  UserAlreadyExistedException(super.message);
}
