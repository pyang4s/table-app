import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import '../../constants/global_variables.dart';
import 'package:universal_html/html.dart' as html;


void exportAgentData() {
  itemList = [<String>["Location", "First Name", "Last Name", "Agent ID", "Rentals CY", "WFI/GTL Rentals", "WFI/GTL Revenues", "Penetration Rate(%)", "Agent Ref Id"]];
  itemList.add(["Agent's location",
    "Agent's first name",
    "Agent's last name",
    "Must be a unique ID",
    "Number",
    "Number",
    "Currency",
    "WFI/GTL Rentals / Rentals CY",
    "Agent's id in the database"]);

  for (int i = 0; i < foundAgents.length; i++){
    itemList.add(<String>[
      foundAgents[i].getLocationAsString(),
      foundAgents[i].getFirstNameAsString(),
      foundAgents[i].getLastNameAsString(),
      foundAgents[i].getAgentIdAsString(),
      foundAgents[i].getRentalsCyAsString(),
      foundAgents[i].getRentalsCyAsString(),
      foundAgents[i].getWfiGtlRevenuesAsString(),
      foundAgents[i].getPenetrationRateAsString(),
      foundAgents[i].getAgentRefIdAsString()]);
  }
  //for csv file
  //add items to the item list
  String csvData = const ListToCsvConverter().convert(itemList);
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MM-dd-yyy-HH-mm-ss').format(now);

  final bytes = utf8.encode(csvData);

  final blob = html.Blob([bytes]);

  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor  = html.document.createElement('a') as html.AnchorElement..href = url..style.display = 'none'..download = 'agent_list_export_$formattedDate.csv';

  html.document.body!.children.add(anchor);

  anchor.click();

  html.Url.revokeObjectUrl(url);

}