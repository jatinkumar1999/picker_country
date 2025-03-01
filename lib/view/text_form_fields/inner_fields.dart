import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import '../../controller/picker_contry_provider.dart';
import '../../modal/picker_model.dart';
import '../../picker_country.dart';

class PickerInnerFields extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;
  const PickerInnerFields(
      {super.key, this.controller, this.onChanged, this.hintText});

  @override
  State<PickerInnerFields> createState() => _PickerInnerFieldsState();
}

class _PickerInnerFieldsState extends State<PickerInnerFields> {
  Country? cont;
  void setCountry(Country? selectedCountry) {
    cont = selectedCountry;
    setState(() {});
  }

  // Get the system country code using the window locale
  String getSystemCountryCode() {
    String countryCode =
        ui.window.locale.toString(); // Get the full locale string
    List<String> localeParts = countryCode.split('_');
    if (localeParts.length > 1) {
      return localeParts[
          1]; // Return the country code (e.g., 'US' for United States)
    }
    return 'US'; // Default to 'US' if country code not found
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PickerContryProvider>(
      create: (context) => PickerContryProvider(),
      builder: (context, child) => Consumer<PickerContryProvider>(
        builder: (context, controller, _) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) async {
              // var code = getSystemCountryCode();
              // log('code=>$code');
              controller.getPreSelectedCountryCode();
            },
          );
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: TextFormField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                hintText: widget.hintText,
                border: InputBorder.none,
                prefixIcon: GestureDetector(
                  onTap: () {
                    PickerCountry.picker(
                      context,
                      isDialog: true,
                      // isBottomSheet: true,
                      // isFullScreen: true,
                      onComplete: (country) {
                        setCountry(country);
                      },
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: cont == null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                controller.selectedCountryFlag,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text('+${controller.selectedCountryCode}'),
                              const SizedBox(width: 10),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                controller.countryCodeToEmoji(
                                  cont?.countryCode ?? '',
                                ),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text('+${cont?.phoneCode ?? ""}'),
                              const SizedBox(width: 10),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
