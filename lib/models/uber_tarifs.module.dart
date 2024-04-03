import 'dart:math';

import 'package:uber_clone/models/uber_info.module.dart';

class UberTarifs {
  UberTarifs({
    required double price1,
    required double price2,
    required double price3,
    required double price4,
    required double price5,
    required double price6,
    required double price7,
  })  : _price1 = price1,
        _price2 = price2,
        _price3 = price3,
        _price4 = price4,
        _price5 = price5,
        _price6 = price6,
        _price7 = price7;

  final double _price1;
  final double _price2;
  final double _price3;
  final double _price4;
  final double _price5;
  final double _price6;
  final double _price7;

  int get randomDriverTime {
    final Random random = Random();
    return random.nextInt(8) + 3;
  }

  List<Map<String, dynamic>> get basic => [
        {
          "image": 'assets/images/car3.jpg',
          "name": 'Comfort',
          "price": '$_price1',
          "time": randomDriverTime,
          "people": 4,
          'desc': 'New cars with external legroom',
          "fast": true,
        },
        {
          "image": 'assets/images/car1.jpg',
          "name": 'UberX',
          "price": '$_price2',
          "time": randomDriverTime,
          "people": 4,
          "fast": true,
          'desc': 'Everyday premium rides',
        },
        {
          "image": 'assets/images/car4.jpg',
          "name": 'UberXL',
          "price": '$_price3',
          "time": randomDriverTime,
          "people": 5,
          "fast": false,
          'desc': 'Available trips for groups of up to 6 people',
        },
        {
          "image": 'assets/images/car2.jpg',
          "name": 'VanXL',
          "price": '$_price4',
          "time": randomDriverTime,
          "fast": false,
          "people": 7,
          'desc': 'Premium vehicles for larger groups',
        },
      ];

  List<Map<String, dynamic>> get popular => [
        {
          "image": 'assets/images/car2.jpg',
          "name": 'Black',
          "price": '$_price5',
          "time": randomDriverTime,
          "people": 4,
          "fast": true,
          'desc': 'High quality cars with the best drivers',
        },
        {
          "image": 'assets/images/car5.jpg',
          "name": 'Green',
          "price": '$_price6',
          "time": randomDriverTime,
          "people": 4,
          "fast": false,
          'desc': 'Everyday fully electric vehicles',
        },
        {
          "image": 'assets/images/car1.jpg',
          "name": 'Family',
          "price": '$_price7',
          "time": randomDriverTime,
          "people": 4,
          "fast": false,
          'desc': 'Premium rides with child car seats',
        },
      ];

  factory UberTarifs.init(UberInfo uberInfo) => UberTarifs(
        price1: uberInfo.price1,
        price2: uberInfo.price2,
        price3: uberInfo.price3,
        price4: uberInfo.price4,
        price5: uberInfo.price5,
        price6: uberInfo.price6,
        price7: uberInfo.price7,
      );
}
