import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/agent_model.dart';

///This file contains variables that are used throughout the project
// for csv export
List<List<String>> itemList = [];
List<String> strList = [];
List<int> csvBytes = [];
List<List<dynamic>> fromCsvList = [];
var agentIdArr = [];
var agentReference = [];

//load to interface on build
List<AgentModel> allAgents = [];
List<AgentModel> foundAgents = [];
bool isLoading = false;

//variables to check whether data is being sorted desc
bool locationDesc = true;
bool agentFirstNameDesc = true;
bool agentLastNameDesc = true;
bool agentIdDesc = true;
bool rentalsCyDesc = true;
bool wfiGtlRentalsDesc = true;
bool wfiGtlRevenuesDesc = true;
bool penetrationRateDesc = false;

//variables to check whether text field is visible
bool locationVis = false;
bool agentNameVis= false;
bool agentFirstNameVis = false;
bool agentLastNameVis = false;
bool agentIdVis = false;
bool rentalsCyVis = false;
bool wfiGtlRentalsVis = false;
bool wfiGtlRevenuesVis = false;
bool penetrationRateVis = false;

// Model variables
late String addLocation;
late String addAgentFirstName;
late String addAgentLastName;
late String addAgentId;
late String addRentalsCy;
late String addWfiGtlRentalsCy;
late String addWfiGtlRevenuesCy;
late double addPenetrationRate;

final agentFirstNameCtlr = TextEditingController();
final agentLastNameCtlr = TextEditingController();
final agentIdCtlr = TextEditingController();
final rentalsCyCtlr = TextEditingController();
final wfiGtlRentalsCtlr = TextEditingController();
final wfiGtlRevenuesCtlr = TextEditingController();

late AgentModel agentObject;

// List to hold all available locations
var locationArr = [
  "Denver, CO",
  "Tulsa, OK",
  "Minneapolis, MN",
  "Las Vegas, NV",
  "Sacramento, CA"
];

//list of al available locations in drop down
List<DropdownMenuItem<String>> get dropDownItems{
  List<DropdownMenuItem<String>> locationItems = [
    const DropdownMenuItem(child: Text('Denver, CO'),value:'Denver, CO'),
    const DropdownMenuItem(child: Text('Tulsa, OK'),value:'Tulsa, OK'),
    const DropdownMenuItem(child: Text('Minneapolis, MN'),value:'Minneapolis, MN'),
    const DropdownMenuItem(child: Text('Las Vegas, NV'),value:'Las Vegas, NV'),
    const DropdownMenuItem(child: Text('Sacramento, CA'),value:'Sacramento, CA'),
  ];
  return locationItems;
}
//value that is the default selection on location drop down
var selectedValue = "Denver, CO";

//initiating format for currency
final formatCurrency = NumberFormat.simpleCurrency();
