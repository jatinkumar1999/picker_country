import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/picker_contry_provider.dart';
import '../modal/picker_model.dart';
import 'widgets/common_search_and_list_view.dart';
import 'widgets/full_screen_view.dart';

class PickerCountryView extends StatefulWidget {
  final bool? isDialog;
  final bool? isBottomSheet;
  final bool? isFullScreen;
  final Function(Country?)? onComplete;
  const PickerCountryView({
    super.key,
    this.onComplete,
    this.isDialog = false,
    this.isBottomSheet = false,
    this.isFullScreen = false,
  });

  @override
  State<PickerCountryView> createState() => _PickerCountryViewState();
}

class _PickerCountryViewState extends State<PickerCountryView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        var pickerProvider =
            Provider.of<PickerContryProvider>(context, listen: false);
        pickerProvider.getPreSelectedCountryCode();
        if ((widget.isBottomSheet ?? false)) {
          await countryBottomSheet(pickerProvider);
        } else if ((widget.isDialog ?? false)) {
          await countryDialog(pickerProvider);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PickerContryProvider>(builder: (context, controller, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: (widget.isDialog == true || widget.isBottomSheet == true)
            ? const SizedBox()
            : FullScreenView(
                controller: controller,
                onComplete: widget.onComplete,
              ),
      );
    });
  }

 

  Future<void> countryBottomSheet(PickerContryProvider controller) =>
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        showDragHandle: true,
        sheetAnimationStyle: AnimationStyle(
          curve: Curves.linear,
          duration: const Duration(milliseconds: 800),
          reverseCurve: Curves.linear,
          reverseDuration: const Duration(milliseconds: 400),
        ),
        builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: ListenableProvider.value(
            value: controller,
            child: CommonSearchAndListView(
              controller: controller,
              onComplete: widget.onComplete,
            ),
          ),
        ),
      ).whenComplete(() {
        if (context.mounted) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      });

  Future<void> countryDialog(PickerContryProvider controller) => showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: false,
        builder: (context) => Dialog(
          insetAnimationCurve: Curves.linear,
          insetAnimationDuration: const Duration(milliseconds: 900),
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListenableProvider.value(
            value: controller,
            child: CommonSearchAndListView(
              controller: controller,
              onComplete: widget.onComplete,
            ),
          ),
        ),
      ).whenComplete(() {
        if (context.mounted) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      });
}
