import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 40,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          primary: buttonTextColor,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        child: const Text("Add"),
      ),
    );
  }
}
