import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'metadata_data_row.dart';

class MetadataDataTable extends StatelessWidget {
  const MetadataDataTable({
    Key? key,
    required this.artistController,
    required this.titleController,
  }) : super(key: key);

  final TextEditingController artistController;
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return DataTable(
        headingRowHeight: 0,
        dataRowHeight: 100,
        columns: [
          DataColumn(label: Container()),
          DataColumn(label: Container()),
        ],
        rows: [
          MetadataDataRow("Artist", ref, artistController),
          MetadataDataRow("Title", ref, titleController),
        ],
      );
    });
  }
}
