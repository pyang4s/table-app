import 'dart:convert';
import 'dart:core';
import 'package:universal_html/html.dart' as html;
import 'package:csv/csv.dart';

downLoadTemplate() {
  List<List<String>> templateList = [];
  templateList = [<String>[
    "Location",
    "First Name",
    "Last Name",
    "Agent ID",
    "Rentals CY",
    "WFI/GTL Rentals",
    "WFI/GTL Revenues",
    "Action",
    "Agent Ref Id"],
    [
      "Agent's location",
      "Agent's first name",
      "Agent's last name",
      "Must be a unique ID",
      "Number",
      "Number",
      "Currency",
      "Add | Update | Delete",
      "Agent's id in the database"
    ]];

  String csvData = const ListToCsvConverter().convert(templateList);
  final bytes = utf8.encode(csvData);
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor  = html.document.createElement('a') as html.AnchorElement..href = url..style.display = 'none'..download = 'agent_list_template.csv';
  html.document.body!.children.add(anchor);
  anchor.click();

  html.Url.revokeObjectUrl(url);
}