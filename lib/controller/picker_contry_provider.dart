import 'package:flutter/material.dart';
import '../modal/picker_model.dart';
import '../picker_country_list.dart';
import '../view/widgets/debouncing.dart';
import 'dart:ui';

class PickerContryProvider extends ChangeNotifier {
  String selectedCountryFlag = '';
  String selectedCountryCode = '';
  List<Country> countryCodeList = <Country>[];
  List<Country> countryCodeListFilter = <Country>[];
  final ScrollController scrollcontroller = ScrollController();
  final debouncing = Debouncer(milliseconds: 400);
  TextEditingController searchController = TextEditingController();
  Country? cont;
  int? phoneLength;
  int? phoneNumber;
  String? validation;
  double height = 55;
  final formKey = GlobalKey<FormState>();

//!Handel Custom Validations
  void setValidations(String number) {
    if (cont == null) {
      validation = 'Please choose country';
      formKey.currentState?.reset();
    } else if (number.isEmpty) {
      validation = 'Please enter phone number';
    } else if (number.length < (phoneLength ?? 0)) {
      validation = 'Please enter valid phone number';
    } else {
      validation = null;
    }
    phoneNumber = number.isNotEmpty ? int.parse(number) : phoneNumber;
    notifyListeners();
  }

  //* Set Country

  void setCountry(Country? selectedCountry) {
    cont = selectedCountry;
    formKey.currentState?.reset();

    setPhoneLength(selectedCountry?.phoneNumberLength ?? 0);
    notifyListeners();
  }
  //? Set Phone Length

  void setPhoneLength(int length) {
    phoneLength = length;
    notifyListeners();
  }

  //! Get Pre select country

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

  //! Get Country Flags

  String countryCodeToEmoji(String countryCode) {
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  void filterCountryList(String search) {
    debouncing.run(() {
      if (search.isEmpty) {
        countryCodeList = countryCodeListFilter;
        searchController.clear();
        notifyListeners();

        return;
      }
      final filterCountries = countryCodeListFilter.where(
        (element) {
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
