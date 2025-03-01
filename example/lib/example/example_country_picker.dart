import 'package:flutter/material.dart';
import 'package:picker_country/modal/picker_model.dart';
import 'package:picker_country/picker_country.dart';
import 'package:picker_country/view/text_form_fields/inner_fields.dart';

class ExampleCountryPicker extends StatefulWidget {
  const ExampleCountryPicker({
    super.key,
  });

  @override
  State<ExampleCountryPicker> createState() => _ExampleCountryPickerState();
}

class _ExampleCountryPickerState extends State<ExampleCountryPicker> {
  Country? selectedCountry;

  void onTapCountryPicker() {
    PickerCountry.picker(
      context,
      // isDialog: true,
      // isBottomSheet: true,
      // isFullScreen: true,
      onComplete: (country) {
        selectedCountry = country;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Picker Country'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: PickerInnerFields(),
            ),
            const SizedBox(height: 20),
            Text(
              'Selected Country',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: selectedCountry != null,
              child: Text(
                '${selectedCountry?.displayName}\n+${selectedCountry?.phoneCode}\n${selectedCountry?.countryCode}\n Phone length:${selectedCountry?.phoneNumberLength}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTapCountryPicker,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
