import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picker_country/constants/package_constant/package_constant.dart';
import 'package:provider/provider.dart';
import '../../constants/asset_constant/asset_constants.dart';
import '../../controller/picker_contry_provider.dart';
import '../../picker_country.dart';

class PickerInnerFields extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onEditingComplete;
  final void Function(String)? onSaved;
  final bool? isDialog;
  final bool? isBottomSheet;
  final bool? isFullScreen;
  final String? hintText;
  const PickerInnerFields(
      {super.key,
      this.controller,
      this.onChanged,
      this.hintText,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onSaved,
      this.isDialog,
      this.isBottomSheet,
      this.isFullScreen});

  @override
  State<PickerInnerFields> createState() => _PickerInnerFieldsState();
}

class _PickerInnerFieldsState extends State<PickerInnerFields> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PickerContryProvider>(
      create: (context) => PickerContryProvider(),
      builder: (context, child) => Consumer<PickerContryProvider>(
        builder: (context, controller, _) {
          return InnerTexFormFieldTile(
            controller: controller,
            hintText: widget.hintText,
            onChanged: widget.onChanged,
            textController: widget.controller,
            onEditingComplete: widget.onEditingComplete,
            onFieldSubmitted: widget.onFieldSubmitted,
            onSaved: widget.onSaved,
            isBottomSheet: widget.isBottomSheet,
            isDialog: widget.isDialog,
            isFullScreen: widget.isFullScreen ?? false,
          );
        },
      ),
    );
  }
}

class InnerTexFormFieldTile extends StatelessWidget {
  final PickerContryProvider controller;
  final TextEditingController? textController;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onEditingComplete;
  final void Function(String)? onSaved;
  final bool? isDialog;
  final bool? isBottomSheet;
  final bool isFullScreen;
  const InnerTexFormFieldTile(
      {super.key,
      required this.controller,
      this.onChanged,
      this.hintText,
      this.textController,
      this.isDialog,
      this.isBottomSheet,
      this.isFullScreen = true,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: controller.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color:
                    controller.validation != null ? Colors.red : Colors.black,
              ),
            ),
            child: TextFormField(
              controller: textController,
              onEditingComplete: () {
                onEditingComplete != null
                    ? onEditingComplete!(
                        '+${controller.cont?.phoneCode} ${controller.phoneNumber ?? ''}')
                    : null;
              },
              onFieldSubmitted: (value) {
                onFieldSubmitted != null
                    ? onFieldSubmitted!(
                        '+${controller.cont?.phoneCode} ${controller.phoneNumber ?? ''}')
                    : null;
              },
              onSaved: (newValue) {
                onSaved != null
                    ? onSaved!(
                        '+${controller.cont?.phoneCode} ${controller.phoneNumber ?? ''}')
                    : null;
              },
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(value);
                }
                controller.debouncing.run(() {
                  controller.setValidations(value);
                });
              },
              maxLines: 1,
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: false, signed: false),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(controller.phoneLength),
              ],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                hintText: hintText,
                border: InputBorder.none,
                prefixIcon: GestureDetector(
                  onTap: () {
                    PickerCountry.picker(
                      context,
                      isDialog: isDialog ?? false,
                      isBottomSheet: isBottomSheet ?? false,
                      isFullScreen: isFullScreen,
                      onComplete: (country) {
                        controller.setCountry(country);
                      },
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: controller.cont == null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 10),
                              Image.asset(
                                IconConstants.earthIcon,
                                width: 25,
                                height: 25,
                                fit: BoxFit.cover,
                                package: PackageConstant.packageName,
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                controller.countryCodeToEmoji(
                                  controller.cont?.countryCode ?? '',
                                ),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '+${controller.cont?.phoneCode ?? ""}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            child: controller.validation == null
                ? const SizedBox()
                : Column(
                    children: [
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          controller.validation ?? '',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
