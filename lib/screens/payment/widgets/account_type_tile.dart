import 'package:flutter/material.dart';

class AccountTypeTile extends StatelessWidget {
  const AccountTypeTile({
    super.key,
    required this.name,
    required this.iconData,
    required this.isSelected,
  });

  final String name;
  final IconData iconData;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.only(right: 15),
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isSelected ? Colors.black : Colors.grey[300],
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: isSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
