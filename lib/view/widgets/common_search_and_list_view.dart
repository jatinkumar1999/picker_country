import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/picker_contry_provider.dart';
import '../../modal/picker_model.dart';
import 'common_textform_field.dart';

class CommonSearchAndListView extends StatelessWidget {
  final PickerContryProvider controller;
  final Function(Country?)? onComplete;

  const CommonSearchAndListView({
    super.key,
    required this.controller,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PickerContryProvider>(builder: (context, controller, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    child: CommonTextFormField(
                      hintText: 'Search...',
                      controller: controller.searchController,
                      onChanged: controller.filterCountryList,
                    ),
                  ),
                ),
                if (controller.searchController.text.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      controller.filterCountryList('');
                    },
                    icon: const Icon(Icons.cancel),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Scrollbar(
                  controller: controller.scrollcontroller,
                  interactive: true,
                  radius: const Radius.circular(10),
                  thickness: 6,
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: ListView.builder(
                    controller: controller.scrollcontroller,
                    itemCount: controller.countryCodeList.length,
                    itemBuilder: (context, index) {
                      var country = controller.countryCodeList[index];
                      return ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          onComplete!(country);
                        },
                        leading: Text(
                          controller.countryCodeToEmoji(
                            country.countryCode ?? '',
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        title: highlightText(country.displayName ?? '',
                            controller.searchController.text),

                        // title: Text(
                        //   country.displayName ?? '',
                        //   style: const TextStyle(
                        //     fontSize: 20,
                        //   ),
                        // ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

/// **Function to make the searched text bold**
Widget highlightText(String text, String query) {
  if (query.isEmpty) return Text(text);

  String lowerText = text.toLowerCase();
  String lowerQuery = query.toLowerCase();

  int startIndex = lowerText.indexOf(lowerQuery);
  if (startIndex == -1) return Text(text); // No match found

  int endIndex = startIndex + query.length;

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text.substring(0, startIndex),
          style: const TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: text.substring(startIndex, endIndex),
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        TextSpan(
          text: text.substring(endIndex),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}
