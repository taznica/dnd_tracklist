import 'package:flutter/material.dart';

import '../constants/colors.dart';

class DropTargetArea extends StatelessWidget {
  const DropTargetArea({
    Key? key,
    required bool dragging,
  })  : _dragging = dragging,
        super(key: key);

  final bool _dragging;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          color: _dragging ? dropTargetAreaDraggingColor : dropTargetAreaColor,
        ),
        child: Stack(
          children: const [
            Center(
              child: Text(
                "Drop here",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
