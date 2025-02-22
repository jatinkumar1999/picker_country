import 'dart:developer';

import 'package:flutter/material.dart';
import '../modal/picker_model.dart';
import '../picker_country_list.dart';
import 'dart:ui';

import '../view/widgets/debouncing.dart';

class PickerContryProvider extends ChangeNotifier {
  String selectedCountryFlag = '';
  String selectedCountryCode = '';
  List<Country> countryCodeList = <Country>[];
  List<Country> countryCodeListFilter = <Country>[];
    final ScrollController scrollcontroller = ScrollController();


  TextEditingController searchController = TextEditingController();
  void getPreSelectedCountryCode() {
    // ignore: deprecated_member_use
    final Locale locale = window.locale;
    final String countryCode = locale.countryCode ?? 'Unknown';

    countryCodeList = countryCodes.map((e) => Country.fromMap(e)).toList();
    countryCodeListFilter =
        countryCodes.map((e) => Country.fromMap(e)).toList();

    if (countryCode.toLowerCase() != 'Unknown'.toLowerCase()) {
      var countryData = countryCodeList.firstWhere((e) =>
          e.countryCode?.toLowerCase().trim() ==
          countryCode.toLowerCase().trim());

      var flag = countryCodeToEmoji(countryData.countryCode ?? "");
      selectedCountryFlag = flag;
      selectedCountryCode = countryData.phoneCode ?? "";
    }
    notifyListeners();
  }

  String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  var deBouncing = Debouncer(milliseconds: 400);
  void filterCountryList(String search) {
    deBouncing.run(() {
      if (search.isEmpty) {
        countryCodeList = countryCodeListFilter;
        searchController.clear();
        notifyListeners();

        return;
      }
      final filterCountries = countryCodeListFilter.where(
        (element) {
          log('element.phoneCode==>>${element.toMap()}');
          return (element.countryCode ?? '').toUpperCase() ==
                  search.toUpperCase() ||
              (element.name ?? '')
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              element.phoneCode ==
                  (search.contains('+')
                      ? search.replaceAll("+", '').trim()
                      : search);
        },
      ).toList();

      countryCodeList = filterCountries;
      notifyListeners();
    });
  }
}
