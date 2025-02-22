import 'package:flutter/material.dart';
import 'package:picker_country/modal/picker_model.dart';
import 'package:picker_country/picker_country.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picker Country',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExampleCountryPicker(),
    );
  }
}

class ExampleCountryPicker extends StatefulWidget {
  const ExampleCountryPicker({
    super.key,
  });

  @override
  State<ExampleCountryPicker> createState() => _ExampleCountryPickerState();
}

class _ExampleCountryPickerState extends State<ExampleCountryPicker> {
  Country? selectedCountry;

  void _incrementCounter() {
    PickerCountry.picker(
      context,
      // isDialog: true,
      // isBottomSheet: true,
      isFullScreen: true,
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
