class UberInfo {
  final String guid;
  final double price1;
  final double price2;
  final double price3;
  final double price4;
  final double price5;
  final double price6;
  final double price7;
  final String time;
  final String currency;

  UberInfo({
    required this.guid,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.price4,
    required this.price5,
    required this.price6,
    required this.price7,
    required this.time,
    required this.currency,
  });

  factory UberInfo.fromArray(List<dynamic> array) => UberInfo(
        guid: array[0],
        price1: array[1],
        price2: array[2],
        price3: array[3],
        price4: array[4],
        price5: array[5],
        price6: array[6],
        price7: array[7],
        time: array[8] ?? "12:25",
        currency: array[9],
      );
}
