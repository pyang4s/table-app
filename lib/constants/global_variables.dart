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
  "ABQ",
  "ATL",
  "AUS",
  "BDL",
  "BFL",
  "BNA",
  "BOI",
  "BOS",
  "BUR",
  "BWI",
  "Canada",
  "CLT",
  "CMH",
  "DC2",
  "DCA",
  "DEN",
  "DFW",
  "DTW",
  "E11",
  "E43",
  "E47",
  "E49",
  "E50",
  "E52",
  "E53",
  "E55",
  "E56",
  "E58",
  "E59",
  "E61",
  "E62",
  "E65",
  "E67",
  "E68",
  "E87",
  "ELP",
  "EUG",
  "EWR",
  "FAT",
  "FLL",
  "FRI",
  "GEG",
  "HNL",
  "HOU",
  "IAD",
  "IAH",
  "IDA",
  "IND",
  "ITO",
  "JAC",
  "JFK",
  "KOA",
  "LAS",
  "LAX",
  "LGA",
  "LGB",
  "LIH",
  "MCO",
  "MDW",
  "MIA",
  "MON",
  "MSP",
  "MW5",
  "N2Y",
  "NY5",
  "OAK",
  "OGG",
  "ONT",
  "ORD",
  "ORF",
  "PDX",
  "PHX",
  "PSC",
  "PSP",
  "RDU",
  "RNO",
  "RSW",
  "SAN",
  "SAT",
  "SBA",
  "SEA",
  "SF1",
  "SFB",
  "SFO",
  "SJC",
  "SLC",
  "SMF",
  "SNA",
  "SUN",
  "THU",
  "TUE",
  "TUS",
  "W42",
  "W54",
  "WED",
  "XB13",
  "XB14",
  "XB15",
  "XB21",
  "XB22",
  "XB7",
  "XB9",
  "YOW",
  "YUL",
  "YVR",
  "YYC",
  "YYZ",
];

//list of al available locations in drop down
List<DropdownMenuItem<String>> get dropDownItems{
  List<DropdownMenuItem<String>> locationItems = [
    const DropdownMenuItem(child: Text('ABQ'),value:'ABQ'),
    const DropdownMenuItem(child: Text('ATL'),value:'ATL'),
    const DropdownMenuItem(child: Text('AUS'),value:'AUS'),
    const DropdownMenuItem(child: Text('BDL'),value:'BDL'),
    const DropdownMenuItem(child: Text('BFL'),value:'BFL'),
    const DropdownMenuItem(child: Text('BNA'),value:'BNA'),
    const DropdownMenuItem(child: Text('BOI'),value:'BOI'),
    const DropdownMenuItem(child: Text('BOS'),value:'BOS'),
    const DropdownMenuItem(child: Text('BUR'),value:'BUR'),
    const DropdownMenuItem(child: Text('BWI'),value:'BWI'),
    const DropdownMenuItem(child: Text('Canada'),value:'Canada'),
    const DropdownMenuItem(child: Text('CLT'),value:'CLT'),
    const DropdownMenuItem(child: Text('CMH'),value:'CMH'),
    const DropdownMenuItem(child: Text('DC2'),value:'DC2'),
    const DropdownMenuItem(child: Text('DCA'),value:'DCA'),
    const DropdownMenuItem(child: Text('DEN'),value:'DEN'),
    const DropdownMenuItem(child: Text('DFW'),value:'DFW'),
    const DropdownMenuItem(child: Text('DTW'),value:'DTW'),
    const DropdownMenuItem(child: Text('E11'),value:'E11'),
    const DropdownMenuItem(child: Text('E43'),value:'E43'),
    const DropdownMenuItem(child: Text('E47'),value:'E47'),
    const DropdownMenuItem(child: Text('E49'),value:'E49'),
    const DropdownMenuItem(child: Text('E50'),value:'E50'),
    const DropdownMenuItem(child: Text('E52'),value:'E52'),
    const DropdownMenuItem(child: Text('E53'),value:'E53'),
    const DropdownMenuItem(child: Text('E55'),value:'E55'),
    const DropdownMenuItem(child: Text('E56'),value:'E56'),
    const DropdownMenuItem(child: Text('E58'),value:'E58'),
    const DropdownMenuItem(child: Text('E59'),value:'E59'),
    const DropdownMenuItem(child: Text('E61'),value:'E61'),
    const DropdownMenuItem(child: Text('E62'),value:'E62'),
    const DropdownMenuItem(child: Text('E65'),value:'E65'),
    const DropdownMenuItem(child: Text('E67'),value:'E67'),
    const DropdownMenuItem(child: Text('E68'),value:'E68'),
    const DropdownMenuItem(child: Text('E87'),value:'E87'),
    const DropdownMenuItem(child: Text('ELP'),value:'ELP'),
    const DropdownMenuItem(child: Text('EUG'),value:'EUG'),
    const DropdownMenuItem(child: Text('EWR'),value:'EWR'),
    const DropdownMenuItem(child: Text('FAT'),value:'FAT'),
    const DropdownMenuItem(child: Text('FLL'),value:'FLL'),
    const DropdownMenuItem(child: Text('FRI'),value:'FRI'),
    const DropdownMenuItem(child: Text('GEG'),value:'GEG'),
    const DropdownMenuItem(child: Text('HNL'),value:'HNL'),
    const DropdownMenuItem(child: Text('HOU'),value:'HOU'),
    const DropdownMenuItem(child: Text('IAD'),value:'IAD'),
    const DropdownMenuItem(child: Text('IAH'),value:'IAH'),
    const DropdownMenuItem(child: Text('IDA'),value:'IDA'),
    const DropdownMenuItem(child: Text('IND'),value:'IND'),
    const DropdownMenuItem(child: Text('ITO'),value:'ITO'),
    const DropdownMenuItem(child: Text('JAC'),value:'JAC'),
    const DropdownMenuItem(child: Text('JFK'),value:'JFK'),
    const DropdownMenuItem(child: Text('KOA'),value:'KOA'),
    const DropdownMenuItem(child: Text('LAS'),value:'LAS'),
    const DropdownMenuItem(child: Text('LAX'),value:'LAX'),
    const DropdownMenuItem(child: Text('LGA'),value:'LGA'),
    const DropdownMenuItem(child: Text('LGB'),value:'LGB'),
    const DropdownMenuItem(child: Text('LIH'),value:'LIH'),
    const DropdownMenuItem(child: Text('MCO'),value:'MCO'),
    const DropdownMenuItem(child: Text('MDW'),value:'MDW'),
    const DropdownMenuItem(child: Text('MIA'),value:'MIA'),
    const DropdownMenuItem(child: Text('MON'),value:'MON'),
    const DropdownMenuItem(child: Text('MSP'),value:'MSP'),
    const DropdownMenuItem(child: Text('MW5'),value:'MW5'),
    const DropdownMenuItem(child: Text('N2Y'),value:'N2Y'),
    const DropdownMenuItem(child: Text('NY5'),value:'NY5'),
    const DropdownMenuItem(child: Text('OAK'),value:'OAK'),
    const DropdownMenuItem(child: Text('OGG'),value:'OGG'),
    const DropdownMenuItem(child: Text('ONT'),value:'ONT'),
    const DropdownMenuItem(child: Text('ORD'),value:'ORD'),
    const DropdownMenuItem(child: Text('ORF'),value:'ORF'),
    const DropdownMenuItem(child: Text('PDX'),value:'PDX'),
    const DropdownMenuItem(child: Text('PHX'),value:'PHX'),
    const DropdownMenuItem(child: Text('PSC'),value:'PSC'),
    const DropdownMenuItem(child: Text('PSP'),value:'PSP'),
    const DropdownMenuItem(child: Text('RDU'),value:'RDU'),
    const DropdownMenuItem(child: Text('RNO'),value:'RNO'),
    const DropdownMenuItem(child: Text('RSW'),value:'RSW'),
    const DropdownMenuItem(child: Text('SAN'),value:'SAN'),
    const DropdownMenuItem(child: Text('SAT'),value:'SAT'),
    const DropdownMenuItem(child: Text('SBA'),value:'SBA'),
    const DropdownMenuItem(child: Text('SEA'),value:'SEA'),
    const DropdownMenuItem(child: Text('SF1'),value:'SF1'),
    const DropdownMenuItem(child: Text('SFB'),value:'SFB'),
    const DropdownMenuItem(child: Text('SFO'),value:'SFO'),
    const DropdownMenuItem(child: Text('SJC'),value:'SJC'),
    const DropdownMenuItem(child: Text('SLC'),value:'SLC'),
    const DropdownMenuItem(child: Text('SMF'),value:'SMF'),
    const DropdownMenuItem(child: Text('SNA'),value:'SNA'),
    const DropdownMenuItem(child: Text('SUN'),value:'SUN'),
    const DropdownMenuItem(child: Text('THU'),value:'THU'),
    const DropdownMenuItem(child: Text('TUE'),value:'TUE'),
    const DropdownMenuItem(child: Text('TUS'),value:'TUS'),
    const DropdownMenuItem(child: Text('W42'),value:'W42'),
    const DropdownMenuItem(child: Text('W54'),value:'W54'),
    const DropdownMenuItem(child: Text('WED'),value:'WED'),
    const DropdownMenuItem(child: Text('XB13'),value:'XB13'),
    const DropdownMenuItem(child: Text('XB14'),value:'XB14'),
    const DropdownMenuItem(child: Text('XB15'),value:'XB15'),
    const DropdownMenuItem(child: Text('XB21'),value:'XB21'),
    const DropdownMenuItem(child: Text('XB22'),value:'XB22'),
    const DropdownMenuItem(child: Text('XB7'),value:'XB7'),
    const DropdownMenuItem(child: Text('XB9'),value:'XB9'),
    const DropdownMenuItem(child: Text('YOW'),value:'YOW'),
    const DropdownMenuItem(child: Text('YUL'),value:'YUL'),
    const DropdownMenuItem(child: Text('YVR'),value:'YVR'),
    const DropdownMenuItem(child: Text('YYC'),value:'YYC'),
    const DropdownMenuItem(child: Text('YYZ'),value:'YYZ'),
  ];
  return locationItems;
}
//value that is the default selection on location drop down
var selectedValue = "ABQ";

//initiating format for currency
final formatCurrency = NumberFormat.simpleCurrency();
