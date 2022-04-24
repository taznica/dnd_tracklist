import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/colors.dart';

class MetadataDataRow extends DataRow {
  MetadataDataRow(
    String headerText,
    WidgetRef ref,
    TextEditingController controller,
  ) : super(
          cells: [
            DataCell(
              Text(
                headerText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataCell(
              SizedBox(
                width: 120,
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: textFieldColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                  cursorColor: primaryColor,
                  maxLines: null,
                ),
              ),
            ),
          ],
        );
}
