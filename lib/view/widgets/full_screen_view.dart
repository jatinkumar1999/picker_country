import 'package:flutter/material.dart';
import '../../controller/picker_contry_provider.dart';
import '../../modal/picker_model.dart';
import 'common_search_and_list_view.dart';

class FullScreenView extends StatelessWidget {
  final PickerContryProvider controller;
  final Function(Country?)? onComplete;

  const FullScreenView({super.key, required this.controller, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CommonSearchAndListView(
        controller: controller,
        onComplete: onComplete,
      ),
    );
  }
}
