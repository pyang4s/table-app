import 'package:file_picker/file_picker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../../providers/bulk_updates_provider.dart';
import 'read_file.dart';


pickCsvFile(BuildContext context) async {
  const String? _extension="csv";
  // opens storage to pick files and the picked file or files
  // are assigned into result and if no file is chosen result is null.
  // you can also toggle "allowMultiple" true or false depending on your need
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: (_extension.isNotEmpty)
        ? _extension.replaceAll(' ', '').split(',')
        : null,
  );
  // if no file is picked
  if (result == null) return;
  // we get the file from result object
  final file = result.files.first;
  //Show file name in the alert box
  context.read<BulkUpdatesProvider>().setFileName(file.name);
  // log the name, size and bytes of the picked file for debugging
  //print(file.name);
  //print(file.size);
  //print(file.bytes!);
  // Send bytes to be read
  context.read<BulkUpdatesProvider>().setFileBytes(file.bytes);
  readCsvFile(context.read<BulkUpdatesProvider>().fileBytes);
}