import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gsheets/gsheets.dart';

final gsheetsProvider = FutureProvider<GSheets>((ref) async {
  final credentials = await rootBundle.loadString(".env/credentials.json");
  return GSheets(credentials);
});
