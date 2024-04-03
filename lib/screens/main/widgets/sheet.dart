import "dart:js" as js;

import 'package:flutter/material.dart';
import 'package:uber_clone/models/uber_info.module.dart';
import 'package:uber_clone/screens/main/widgets/apple_pay.dart';
import 'package:uber_clone/screens/main/widgets/uber_card.dart';
import 'package:uber_clone/screens/payment/view/payment.dart';

class CustomSheet extends StatefulWidget {
  const CustomSheet({
    super.key,
    required this.uberInfo,
    required this.basic,
    required this.popular,
  });

  final UberInfo uberInfo;
  final List<Map<String, dynamic>> basic;
  final List<Map<String, dynamic>> popular;

  @override
  State<CustomSheet> createState() => _CustomSheetState();
}

class _CustomSheetState extends State<CustomSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  bool isExpanded = false;
  bool isMax = false;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.size > 0.53) {
        setState(() {
          isExpanded = true;
        });
      } else {
        setState(() {
          isExpanded = false;
        });
      }
    });
    controller.addListener(() {
      if (controller.size > 0.9) {
        setState(() {
          isMax = true;
        });
      } else {
        setState(() {
          isMax = false;
        });
      }
    });
    super.initState();
  }

  String selectedName = 'Comfort';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: sheet,
      initialChildSize: 0.5,
      maxChildSize: 1,
      minChildSize: 0.5,
      controller: controller,
      builder: (context, scrollController) => Column(
        children: [
          AnimatedScale(
            scale: isMax ? 0 : 1,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              child: isMax
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            js.context.callMethod('eval', [
                              'window.location.href = "https://www.google.com/"'
                            ]);
                          },
                          child: const Text(
                            'Google',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                BoxShadow(
                                  offset: Offset(0, -1),
                                  blurRadius: 10,
                                  color: Colors.black,
                                  spreadRadius: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.near_me,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: CustomScrollView(
                            controller: scrollController,
                            slivers: [
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 7,
                                ),
                              ),
                              sliverAppBar(),
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 20,
                                ),
                              ),
                              ...List.generate(
                                widget.basic.length,
                                (index) => SliverToBoxAdapter(
                                  child: UberCard(
                                    image: widget.basic[index]['image'],
                                    name: widget.basic[index]['name'],
                                    desc: widget.basic[index]['desc'],
                                    price: widget.basic[index]['price'],
                                    peopleCount: widget.basic[index]['people'],
                                    isSelected: widget.basic[index]['name'] ==
                                        selectedName,
                                    onTap: () => changeIndex(
                                      widget.basic[index]['name'],
                                    ),
                                    time: widget.uberInfo.time,
                                    divTime: widget.basic[index]['time'],
                                    isFast: widget.basic[index]['fast'],
                                    currency: widget.uberInfo.currency,
                                    isExpanded: isExpanded,
                                  ),
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 20,
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Popular',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ...List.generate(
                                widget.popular.length,
                                (index) => SliverToBoxAdapter(
                                  child: UberCard(
                                    image: widget.popular[index]['image'],
                                    name: widget.popular[index]['name'],
                                    desc: widget.popular[index]['desc'],
                                    price: widget.popular[index]['price'],
                                    peopleCount: widget.popular[index]
                                        ['people'],
                                    isSelected: widget.popular[index]['name'] ==
                                        selectedName,
                                    onTap: () => changeIndex(
                                      widget.popular[index]['name'],
                                    ),
                                    time: widget.uberInfo.time,
                                    divTime: widget.popular[index]['time'],
                                    isFast: widget.popular[index]['fast'],
                                    currency: widget.uberInfo.currency,
                                    isExpanded: isExpanded,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      buildAction(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildAction() => Column(
        children: [
          Divider(
            height: 2,
            color: Colors.black.withOpacity(0.1),
          ),
          const SizedBox(
            height: 10,
          ),
          ApplePayTile(
            onTap: openSheet,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: openSheet,
                    child: Text(
                      'ORDER $selectedName',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );

  void openSheet() => showBottomSheet(
        context: context,
        builder: (context) => const PaymentDialogUI(),
      );

  void changeIndex(String name) {
    setState(() {
      selectedName = name;
    });
  }

  SliverAppBar sliverAppBar() => SliverAppBar(
        floating: false,
        pinned: true,
        snap: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Column(
          children: [
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select trip type',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(15),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Colors.black12.withOpacity(0.1),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
