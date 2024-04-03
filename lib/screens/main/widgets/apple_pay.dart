import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ApplePayTile extends StatelessWidget {
  const ApplePayTile({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 4,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                child: const Icon(
                  Bootstrap.credit_card,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Add payment method',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_sharp,
            size: 30,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
