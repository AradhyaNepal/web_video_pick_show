enum WebVideoPickShowExceptionType {
  noVideoPicked,
  unknown
}

class WebVideoPickShowException {
  final String _value;
  final WebVideoPickShowExceptionType type;

  WebVideoPickShowException(
    this._value, {
    required this.type,
  });

  @override
  String toString() {
    return "Oppsie! $_value";
  }

  String withoutOppsie() {
    return _value;
  }
}
