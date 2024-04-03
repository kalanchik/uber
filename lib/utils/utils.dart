class Utils {
  static bool checkUserAgent(String userAgent) {
    final mobileKeywords = [
      'Mobile',
      'Android',
      'iPhone',
      'iPad',
      'Windows Phone'
    ];

    for (final keyword in mobileKeywords) {
      if (userAgent.contains(keyword)) {
        return true;
      }
    }

    return false;
  }
}
