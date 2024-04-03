import 'package:flutter/material.dart';

class UberCard extends StatelessWidget {
  const UberCard({
    super.key,
    required this.image,
    required this.name,
    required this.desc,
    required this.price,
    required this.peopleCount,
    required this.isSelected,
    required this.onTap,
    required this.time,
    required this.divTime,
    required this.currency,
    required this.isExpanded,
    required this.isFast,
  });

  final String image;
  final String name;
  final String desc;
  final String price;
  final int peopleCount;
  final bool isSelected;
  final void Function() onTap;
  final String time;
  final int divTime;
  final String currency;
  final bool isExpanded;
  final bool isFast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        alignment: AlignmentDirectional.bottomStart,
        curve: Curves.fastOutSlowIn,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: isSelected
              ? !isExpanded
                  ? buildSmallCard()
                  : buildBigCard(context)
              : unSelectedWidget(),
        ),
      ),
    );
  }

  Widget buildSmallCard() {
    return Row(
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: Image.asset(image),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildUberInfo(),
              buildUberTimeInfo(),
              const SizedBox(
                height: 7,
              ),
              isFast
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.bolt,
                            color: Colors.white,
                            size: 15,
                          ),
                          Text(
                            'Faster',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              fontFamily: 'Uber',
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBigCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset(
                image,
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        buildUberInfo(),
        buildUberTimeInfo(),
        Text(
          desc,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  RichText buildUberTimeInfo() => RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: time,
            ),
            const TextSpan(text: ' • '),
            TextSpan(text: 'In $divTime min from you'),
          ],
        ),
      );

  Row buildUberInfo() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  Text(
                    '$peopleCount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ],
          ),
          Text(
            '$price $currency',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ],
      );

  Widget unSelectedWidget() => Row(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image.asset(image),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildUberInfo(),
                buildUberTimeInfo(),
                const SizedBox(
                  height: 5,
                ),
                isExpanded
                    ? Text(
                        desc,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      );
}
