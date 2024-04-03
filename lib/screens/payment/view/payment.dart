import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:uber_clone/screens/payment/widgets/add_card_ui.dart';

class PaymentDialogUI extends StatefulWidget {
  const PaymentDialogUI({super.key});

  static Row buildHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
    required void Function() onTap,
  }) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              InkWell(
                onTap: onTap,
                child: Icon(
                  icon,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  State<PaymentDialogUI> createState() => _PaymentDialogUIState();
}

class _PaymentDialogUIState extends State<PaymentDialogUI> {
  String selectedAccount = 'Personal profile';

  final List<List<dynamic>> accountType = [
    ['Personal profile', Icons.person],
    ['Business enterprise', Icons.work]
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.fastOutSlowIn,
        switchOutCurve: Curves.fastOutSlowIn,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: Material(
          color: Colors.transparent,
          child: currentPage == 0
              ? SizedBox(
                  key: ValueKey<int>(currentPage),
                  child: buildPageOne(context),
                )
              : currentPage == 1
                  ? SizedBox(
                      key: ValueKey<int>(currentPage),
                      child: buildPageTwo(context),
                    )
                  : SizedBox(
                      child: AddCardUI(
                        changePage: () {
                          setState(() {
                            currentPage = 1;
                          });
                        },
                      ),
                    ),
        ),
      ),
    );
  }

  Column buildPageTwo(BuildContext context) {
    return Column(
      children: [
        PaymentDialogUI.buildHeader(
          context,
          title: 'Add a payment method',
          icon: Icons.arrow_back,
          onTap: () {
            setState(() {
              currentPage = 0;
            });
          },
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () {
            setState(() {
              currentPage = 2;
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Bootstrap.credit_card,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          'Credit or debit card',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column buildPageOne(BuildContext context) {
    return Column(
      children: [
        PaymentDialogUI.buildHeader(
          context,
          onTap: () => Navigator.of(context).pop(),
          title: 'Payment Methods',
          icon: Icons.close,
        ),
        const SizedBox(
          height: 20,
        ),
        // SizedBox(
        //   height: 45,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: accountType.length,
        //     itemBuilder: (context, index) => AccountTypeTile(
        //       name: accountType[index][0],
        //       iconData: accountType[index][1],
        //       isSelected: selectedAccount == accountType[index][0],
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   height: 25,
        // ),
        // buildUberCash(),
        const SizedBox(
          height: 25,
        ),
        buildPaymentMethod(),
        const SizedBox(
          height: 25,
        ),
        // buildCupons(),
      ],
    );
  }

  Column buildPaymentMethod() {
    return Column(
      children: [
        // const Row(
        //   children: [
        //     Text(
        //       'Payment method',
        //       style: TextStyle(
        //         fontSize: 22,
        //         fontWeight: FontWeight.w800,
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 15,
        // ),
        InkWell(
          onTap: () {
            setState(() {
              currentPage = 1;
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 25,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Add a payment method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column buildCupons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Promocode',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            InkWell(
              onTap: () {},
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              splashColor: Colors.transparent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text(
                  'More details',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  size: 25,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Add promocode',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column buildUberCash() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Uber Cash',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              CupertinoSwitch(
                value: false,
                activeColor: Colors.black,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      );
}
