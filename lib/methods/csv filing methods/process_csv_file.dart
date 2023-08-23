import "dart:core";
import "package:provider/provider.dart";
import "package:test23/providers/bulk_updates_provider.dart";
import "package:flutter/material.dart";
import "../../constants/global_variables.dart";
import "../../constants/strings.dart";
import '../../models/agent_model.dart';
import "../../providers/home_page_provider.dart";
import '../../widgets/snackbar_widgets/pass_fail_snackbars.dart';
import 'download_error.dart';

processCsvFile (BuildContext context){

  List <String> header = ["Location", "First Name", "Last Name", "Agent ID", "Rentals CY", "WFI/GTL Rentals CY", "WFI/GTL Revenues CY", "Action", "Agent Ref ID"];
  String errorMsgToCsv = "";
  bool errorOccurred = false;
  List<List<dynamic>> agentList = [];
  int countDup = 0;
  List<String> agentIDCsv = [];
  List<String> agentRefIDCsv = [];

  for (var row in fromCsvList){
    if (row.isNotEmpty){
      agentList.add(row);
    }
  }

  List<List<dynamic>> errorCsv = agentList;
  errorCsv[0].add(addErrorToColumn);

  agentIDCsv.clear();
  agentRefIDCsv.clear();
  //Create a list of all agent ids & ref Ids from spreadsheet
  for (int row = 2; row <agentList.length; row++ ){
    agentIDCsv.add(agentList[row][3].toString());
    if(agentList[row][8].toString().isEmpty){
      agentList[row][8] = defaultRefId;
      agentRefIDCsv.add(agentList[row][8].toString());
    } else {
      agentRefIDCsv.add(agentList[row][8].toString());
    }
  }


  // Check for errors
  for (int row = 2; row < agentList.length; row ++){//skip the first two rows in the csv worksheet
    //Condition for error: If all cells are empty, do not set error
    //Condition for error: Check for empty rows
    for (int column = 0; column < 7; column++){
      if (agentList[row][column].toString().isEmpty) {
        //fromCsvList[row].add("Row $row - ${header[column]} is invalid/empty");
        errorMsgToCsv += "${header[column]} is $invalidOrEmpty. ";
        errorOccurred = true;
      }
    }
    //Condition for error: Check for location that is not in database
    if (locationArr.toString().toLowerCase().contains(agentList[row][0].toLowerCase().trim())){
      //print(fromCsvList[row][0].toLowerCase().trim());
    } else {
      errorMsgToCsv += "${header[0]} is $notInLocationList. ";
      errorOccurred = true;
    }

    //Condition for error: Check if agentId already exists in database
    for (var agent in allAgents){
      if(agentList[row][7].toString().trim().toString().toLowerCase() == add && agentList[row][3].toString().trim() == agent.getAgentIdAsString()){
        errorMsgToCsv += "${header[3]} must be a unique id, [${agentList[row][3]}] is already assigned to ${agent.getFullName()}. ";
        errorOccurred = true;
        break;
      }
    }

    //Condition for error: Check for duplicated ids within the spreadsheet
    for (var agentId in agentIDCsv){
      if(agentList[row][3].toString().trim() == agentId.toString().trim()){
        countDup++;
      }
    }
    if (countDup > 1) {
      errorMsgToCsv += dupIdInSpreadsheet;
      errorOccurred = true;
    }

    //Condition for error : Check to ensure rentals numbers are whole numbers
    if (agentList[row][4].toString().isNotEmpty && int.tryParse(agentList[row][4].toString().replaceAll(",", "")) == null){
      errorMsgToCsv += "${header[4]} $wholeNumber. ";
      errorOccurred = true;
    }
    if (agentList[row][5].toString().isNotEmpty && int.tryParse(agentList[row][5].toString().replaceAll(",", "")) == null){
      errorMsgToCsv += "${header[5]} $wholeNumber. ";
      errorOccurred = true;
    }

    //Condition for error: Check whether WFI Rentals exceeds Rentals CY
    if (agentList[row][4].toString().isNotEmpty &&
        agentList[row][5].toString().isNotEmpty &&
        int.tryParse(agentList[row][4].toString().replaceAll(",", "")) != null &&
        int.tryParse(agentList[row][5].toString().replaceAll(",", "")) != null) {
      if (int.parse(agentList[row][5].toString().replaceAll(",", "")) > int.parse(agentList[row][4].toString().replaceAll(",", ""))){
        errorMsgToCsv += "${header[5]} $notExceed ${header[4]}. ";
        errorOccurred = true;
      }
    }

    if (agentList[row][6].toString().isNotEmpty && double.tryParse(agentList[row][6].toString().replaceAll(",", "").replaceAll("\$", "")) == null){
      errorMsgToCsv += "${header[6]} $number. ";
      errorOccurred = true;
    }

    //Condition for error: check if add, update, delete are entered correctly
    if(agentList[row][7].toLowerCase().trim() == add || agentList[row][7].toLowerCase().trim() == update || agentList[row][7].toLowerCase().trim() == delete){
      if (agentList[row][7].toLowerCase().trim() == delete || agentList[row][7].toLowerCase().trim() == update){
        if (agentList[row][8].toString().isEmpty){
          errorMsgToCsv += "${header[8]} $refIdRequired. ";
          errorOccurred = true;
        }
      }
    } else {
      errorMsgToCsv += "${header[7]} $addUpdateDelete. ";
      errorOccurred = true;
    }

    errorCsv[row].add(errorMsgToCsv);
    errorMsgToCsv = "";
    countDup = 0;
  }

  if (errorOccurred){
    //print(errorCsv);
    downloadErrorCsv(errorCsv);
    context.read<BulkUpdatesProvider>().setUploadErrorMessage();
  } else {
    context.read<BulkUpdatesProvider>().setNullFileName();

    AgentModel agentObj;
    String agentRefId;
    String location;
    String firstName;
    String lastName;
    String agentId;
    int rentalsCy;
    int wfiGtlRentalsCy;
    double wfiGtlRevenuesCy;
    double penetrationRate;

    // loop through each row in CSV file
    for (int row = 2; row < agentList.length; row ++){//skip the first two rows

      // Assign values from CSV to variables
      agentRefId = agentList[row][8].toString();
      location = agentList[row][0].toString();
      firstName = agentList[row][1].toString();
      lastName = agentList[row][2].toString();
      agentId = agentList[row][3].toString();
      rentalsCy = int.parse(agentList[row][4].toString().replaceAll(",", ""));
      wfiGtlRentalsCy = int.parse(agentList[row][5].toString().replaceAll(",", ""));
      wfiGtlRevenuesCy = double.parse(agentList[row][6].toString().replaceAll(",", "").replaceAll("\$", ""));
      ((wfiGtlRentalsCy/rentalsCy)*100).toString() == nan? penetrationRate = 0.00 : penetrationRate = (wfiGtlRentalsCy/rentalsCy)*100;

      if (agentList[row][8].toString().isEmpty){
        agentRefId = "";
      } else {
        agentRefId = agentList[row][8];
      } // end of else

      //Initialize new model for agent
      agentObj = AgentModel(
          agentRefId,
          location,
          firstName,
          lastName,
          agentId,
          rentalsCy,
          wfiGtlRentalsCy,
          wfiGtlRevenuesCy,
          penetrationRate
      );


      // Retrieve the action value to determine what steps to take next
      String action = agentList[row][7].toString().toLowerCase().trim();

      switch(action)
      {
        case 'add':
          {
            agentObj.add();
            break;
          }
        case 'update':
          {
            //print("RefID is: ");
            //print(agentObj.getAgentRefId());
            agentObj.updateAgent(agentObj.getAgentRefIdAsString());
            break;
          }
        case 'delete':
          {
            //print("RefID is: ");
            //print(agentObj.getAgentRefId());
            agentObj.deleteAgent(agentObj.getAgentRefIdAsString());
            break;
          }
      } //end of switch statement
    } // end of for loop
    context.read<HomePageProvider>().foundAllAgent();
    Navigator.pop(context);
    showSnackBarSuccess(ScaffoldMessenger.of(context), importCompleted);
  }
}
