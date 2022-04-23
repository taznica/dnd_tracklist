import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/track_provider.dart';
import 'metadata_data_row.dart';

class MetadataDataTable extends StatelessWidget {
  const MetadataDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => DataTable(
        headingRowHeight: 0,
        dataRowHeight: 100,
        columns: [
          DataColumn(label: Container()),
          DataColumn(label: Container()),
        ],
        rows: [
          MetadataDataRow(
            "Artist",
            ref.watch(trackProvider).artist,
          ),
          MetadataDataRow(
            "Title",
            ref.watch(trackProvider).title,
          ),
        ],
      ),
    );
  }
}
