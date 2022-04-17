import 'package:flutter/material.dart';

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
            color: Color(0xff434954),
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff434954),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        hintText: " Tracklist URL (Google Sheets)",
        hintStyle: const TextStyle(
          color: Color(0xff434954),
          fontSize: 14.0,
        ),
      ),
      cursorColor: const Color(0xff434954),
      cursorWidth: 1.5,
    );
  }
}
