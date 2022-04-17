import 'package:flutter/material.dart';

class MetadataDataRow extends DataRow {
  MetadataDataRow(String headerText, String contentText)
      : super(
          cells: [
            DataCell(
              Text(
                headerText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataCell(
              Text(contentText),
            ),
          ],
        );
}
