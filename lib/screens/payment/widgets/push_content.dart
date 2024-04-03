import 'package:flutter/material.dart';

class PushContent extends StatelessWidget {
  const PushContent({
    super.key,
    required this.controller,
    required this.header,
    required this.onSubmit,
    required this.isSms,
    this.error,
  });

  final TextEditingController controller;
  final String header;
  final VoidCallback onSubmit;
  final bool isSms;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                header,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            // IconButton(
            //   onPressed: () => Navigator.of(context).pop(),
            //   icon: const Icon(Icons.close),
            // ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        isSms
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLength: 10,
                      buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              required maxLength}) =>
                          const SizedBox.shrink(),
                      controller: controller,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                        filled: true,
                        hintText: 'Code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : const SizedBox.shrink(),
        error == null
            ? const SizedBox.shrink()
            : Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    error!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onSubmit();
                },
                child: Text(
                  isSms ? 'Send' : 'Okay',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
