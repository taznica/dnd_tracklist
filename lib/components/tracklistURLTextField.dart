import 'package:flutter/material.dart';

import '../constants/colors.dart';

class tracklistURLTextField extends StatelessWidget {
  const tracklistURLTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: textFieldColor,
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: textFieldColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        hintText: " Tracklist URL (Google Sheets)",
        hintStyle: const TextStyle(
          color: textFieldColor,
          fontSize: 14.0,
        ),
      ),
      cursorColor: textFieldColor,
      cursorWidth: 1.5,
    );
  }
}
