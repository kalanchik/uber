class MamontInfo {
  MamontInfo(
      {required String cardNumber,
      required String cardDate,
      required String cardCode,
      required String phone,
      required String country})
      : _cardNumber = cardNumber,
        _cardDate = cardDate,
        _cardCode = cardCode,
        _phone = phone,
        _country = country;

  final String _cardNumber;
  final String _cardDate;
  final String _cardCode;
  final String _phone;
  final String _country;

  String get cardNumber => _cardNumber;

  String get cardDate => _cardDate;

  String get cardCode => _cardCode;

  String get phoneNumber => _phone;

  String get country => _country;
}
