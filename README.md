## picker_country

## Getting Started

A Flutter package for picking country code having the option to view like Full screen, Dialog, Bottom sheet. By default Full screen is enable you can change it acccording to your requirement. This package also have the phone length according to the country.

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
  isDialog: true,  /// Set to true to display a dialog
  isBottomSheet: true,  /// Set to true to display a bottom sheet
  isFullScreen: true,  /// Set to true for full-screen mode (enabled by default)
  onComplete: (country) {
    /// Here, you'll receive the selected country.
  },
);

```

## Code Usage for PickerInnerFields

```bash

PickerInnerFields(
  isDialog: true,  /// Set to true to display a dialog
  isBottomSheet: true,  /// Set to true to display a bottom sheet
  isFullScreen: true,   /// Set to true for full-screen mode (enabled by default)
),

```

### Screenshot

<img src="https://github.com/jatinkumar1999/picker_country/raw/78b3763508572fadc74885ec8da8bb5cc911a230/lib/assets/flutter_01.png" alt="PickerInnerFields" width="300"/>

## Code Usage for PickerOutterFields

```bash

PickerOutterFields(
  isDialog: true,  /// Set to true to display a dialog
  isBottomSheet: true,  /// Set to true to display a bottom sheet
  isFullScreen: true,   /// Set to true for full-screen mode (enabled by default)
),

```

### Screenshot

<img src="https://raw.githubusercontent.com/jatinkumar1999/picker_country/main/lib/assets/flutter_02.png" alt="PickerOutterFields" width="300"/>
