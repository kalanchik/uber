import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputAction extends StatelessWidget {
  const InputAction({
    super.key,
    required this.controller,
    this.hintText,
    required this.headerText,
    this.icon,
    this.textInputType = TextInputType.number,
    this.maxLength,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final Widget? icon;
  final String? hintText;
  final String headerText;
  final TextInputType textInputType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                inputFormatters: inputFormatters,
                cursorColor: Colors.black,
                keyboardType: textInputType,
                controller: controller,
                maxLength: maxLength,
                buildCounter: (
                  context, {
                  required currentLength,
                  required isFocused,
                  required maxLength,
                }) =>
                    const SizedBox.shrink(),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  prefixIcon: icon,
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
