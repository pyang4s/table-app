
import 'package:flutter/material.dart';
import '../../constants/global_variables.dart';
import '../../constants/strings.dart';
import 'package:collection/collection.dart';
import 'package:test23/constants/strings.dart';
import '../../../models/agent_model.dart';
import '../constants/global_variables.dart';
import '../constants/strings.dart';
import '../models/agent_model.dart';

class HomePageProvider extends ChangeNotifier{
  //Variables
  late bool _isLoading;
  late Icon _sortIcon;
  late bool _iconVis;
  //List<AgentObject> _foundAgents = [];

  //Getters
  bool get isLoading => _isLoading;
  Icon get sortIcon => _sortIcon;
  bool get iconVis => _iconVis;

  //List<AgentObject> get foundAgents => _foundAgents;
  //int get foundAgentsCount => _foundAgents.length;

  void setIconDefault(){
    _iconVis = false;
    _sortIcon = const Icon(Icons.keyboard_arrow_up, size: 12, color: Colors.transparent);
    notifyListeners();
  }

  void setIsLoadingTrue(){
    _isLoading = true;
    notifyListeners();
  }

  void setIsLoadingFalse(){
    _isLoading = false;
    notifyListeners();
  }

  void foundAllAgent(){
    foundAgents = allAgents;
    notifyListeners();
  }
  void filterFoundAgents(List<AgentModel> results){
    foundAgents = results;
    notifyListeners();
  }

  void sortAscending(String docName){
    _sortIcon = const Icon(Icons.keyboard_arrow_up, size: 12);
    if (docName == locationDoc || docName == agentNameDoc || docName == agentIdDoc) {
       foundAgents.sort((a, b) =>
          a.getSort(docName).toString().toLowerCase().compareTo(
              b.getSort(docName).toString().toLowerCase()));
    } else {
      foundAgents.sort((a, b) => a.getSort(docName).compareTo(
          b.getSort(docName)));
    }

    notifyListeners();

  }

  void sortDescending(String docName) {
    _sortIcon = const Icon(Icons.keyboard_arrow_down, size: 12);
    if (docName == locationDoc || docName == agentNameDoc || docName == agentIdDoc) {
      foundAgents.sort((b, a) =>
          a.getSort(docName).toString().toLowerCase().compareTo(
              b.getSort(docName).toString().toLowerCase()));
    } else{
      foundAgents.sort((b, a) =>
          a.getSort(docName).compareTo(
              b.getSort(docName)));
    }

    notifyListeners();
  }

  void showAllAgents(){
    foundAgents = allAgents;
    notifyListeners();
  }

  void hideAllTextField(){
    locationVis = agentNameVis = agentIdVis = rentalsCyVis = wfiGtlRentalsVis = wfiGtlRevenuesVis = penetrationRateVis = false;
    foundAgents = allAgents;
    notifyListeners();
  }

  void showTextField(String textField){
    foundAgents = allAgents;

    switch(textField){
      case 'location': {
        locationVis = true;
        agentNameVis = agentIdVis = rentalsCyVis = wfiGtlRentalsVis =  wfiGtlRevenuesVis = penetrationRateVis = false;
      }
      break;
      case 'agent_name': {
        agentNameVis = true;
        locationVis = agentIdVis = rentalsCyVis = wfiGtlRentalsVis =  wfiGtlRevenuesVis = penetrationRateVis = false;
      }
      break;
      case 'agent_id': {
        agentIdVis = true;
        agentNameVis = locationVis = rentalsCyVis = wfiGtlRentalsVis =  wfiGtlRevenuesVis = penetrationRateVis = false;
      }
      break;
      case 'rentals_cy': {
        rentalsCyVis = true;
        agentNameVis = agentIdVis = locationVis = wfiGtlRentalsVis =  wfiGtlRevenuesVis = penetrationRateVis = false;
      }
      break;
      case 'wfi_gtl_rentals': {
        wfiGtlRentalsVis = true;
        agentNameVis = agentIdVis = rentalsCyVis = locationVis =  wfiGtlRevenuesVis = penetrationRateVis = false;
      }
      break;
      case 'wfi_gtl_revenues': {
        wfiGtlRevenuesVis = true;
        agentNameVis = agentIdVis = rentalsCyVis = wfiGtlRentalsVis =  locationVis = penetrationRateVis = false;
      }
      break;
      case 'penetration_rate': {
        penetrationRateVis = true;
        agentNameVis = agentIdVis = rentalsCyVis = wfiGtlRentalsVis =  wfiGtlRevenuesVis = locationVis = false;
      }
      break;
    }
    notifyListeners();
  }
}