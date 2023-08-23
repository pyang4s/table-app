import 'dart:convert';
import 'dart:core';
import 'package:universal_html/html.dart' as html;
import 'package:csv/csv.dart';
// for File

downloadErrorCsv(List<List<dynamic>> errorCsv) {
  List<List<dynamic>> errorList = errorCsv;

  String csvData = const ListToCsvConverter().convert(errorList);
  final bytes = utf8.encode(csvData);
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor  = html.document.createElement('a') as html.AnchorElement..href = url..style.display = 'none'..download = 'agent_list_error.csv';
  html.document.body!.children.add(anchor);
  anchor.click();

  html.Url.revokeObjectUrl(url);
}