import 'package:flutter/material.dart';

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
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffffffff)),
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xff55afa6)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
        child: const Text("Add"),
      ),
    );
  }
}
