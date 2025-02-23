## picker_country

## Getting Started

A Flutter package for picking country code having the option to view like Full screen, Dialog, Bottom sheet. Bt default Full screen is enable you can change it acccording to your requirement. This package also have the phone length according to the country.

Usage

## 1. Add dependency

Please check the latest version before installation. If there is any problem with the new version, please use the previous version

```bash
dependencies:
flutter:
sdk: flutter

# add picker_country

picker_country: ^{latest version}

```

## 2. Add the following imports to your Dart code

```bash

import 'package:picker_country/picker_country.dart';

```

## 3. Usage Code

```bash

///Use this code for the picker country

  PickerCountry.picker(
      context,
       isDialog: true,  /// make the true if want a dialog
       isBottomSheet: true,  /// make the true if want a bottomsheet
      isFullScreen: true,  /// make the true if want a full screen, By defaukt this is enable
      onComplete: (country) {
       /// Here you'll receive your choosen country.
      },
    );

```

# picker_country
