library picker_country;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/picker_contry_provider.dart';
import 'modal/picker_model.dart';
import 'view/picker_country_view.dart';

class PickerCountry {
  static void picker(
    BuildContext context, {
    bool isDialog = false,
    bool isBottomSheet = false,
    final bool isFullScreen = false,
    Function(Country?)? onComplete,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider<PickerContryProvider>(
          create: (context) => PickerContryProvider(),
          builder: (context, child) {
            return PickerCountryView(
              isBottomSheet: isBottomSheet,
              isDialog: isDialog,
              isFullScreen: isFullScreen,
              onComplete: onComplete,
            );
          },
        ),
      ),
    );
  }
}
