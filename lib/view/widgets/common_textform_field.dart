import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;

  const CommonTextFormField({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
        enabledBorder: commonBorder(),
        focusedBorder: commonBorder(),
        focusedErrorBorder: commonBorder(),
        errorBorder: commonBorder(),
        disabledBorder: commonBorder(),
      ),
    );
  }

  OutlineInputBorder commonBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.black,
        ),
      );
}
