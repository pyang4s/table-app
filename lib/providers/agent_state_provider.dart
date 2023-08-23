import 'package:flutter/material.dart';
import '../constants/global_variables.dart';
import '../constants/strings.dart';
import '../models/agent_model.dart';

class AgentStateProvider extends ChangeNotifier{

  String get error => errorMessage;

void setSelectedValue(Object? value){
  selectedValue = value.toString();
      notifyListeners();
}
void defaultMessage(){
  errorMessage = "";
  notifyListeners();
}
  void emptyNameMessage(){
    errorMessage += "- First and last name must be provided\n";
    notifyListeners();
  }

  void emptyIdMessage(){
    errorMessage += "- Agent Id must be provided\n";
    notifyListeners();
  }

  void agentIdAlreadyExistsMessage(AgentModel agent){
    errorMessage += "- This ID is already assigned to agent: ${agent.getFullName()}\n";
  }

  void rentalsCyNotWholeMessage(){
    errorMessage += "- Rentals CY must be a whole number\n";
    notifyListeners();
  }

  void wfiGtlRentalsNotWholeMessage(){
    errorMessage += "- WFI/GTL Rentals CY must be a whole number\n";
    notifyListeners();
  }

  void wfiGtlRevenuesNotNumMessage(){
    errorMessage += "- WFI/GTL Revenues CY must be a number\n";
    notifyListeners();
  }

  void wfiGtlRentalsExceedsMessage(){
    errorMessage += "- WFI/GTL Rentals CY must must not exceed Rentals CY\n";
    notifyListeners();
  }
}