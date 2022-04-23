import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/track_model.dart';
import 'metadata_data_row.dart';

class MetadataDataTable extends StatelessWidget {
  const MetadataDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 0,
      dataRowHeight: 100,
      columns: [
        DataColumn(label: Container()),
        DataColumn(label: Container()),
      ],
      rows: [
        MetadataDataRow(
          "Artist",
          context.select((TrackModel trackModel) => trackModel.artist),
        ),
        MetadataDataRow(
          "Title",
          context.select((TrackModel trackModel) => trackModel.title),
        ),
      ],
    );
  }
}
