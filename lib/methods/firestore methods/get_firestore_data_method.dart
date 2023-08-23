import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/global_variables.dart';
import '../../models/agent_model.dart';
import '../../providers/home_page_provider.dart';

Future <void> getDataFromFireStore(BuildContext context) async {
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('agents');
  allAgents.clear();

  context.read<HomePageProvider>().setIsLoadingTrue();

  // Get docs from collection reference
  QuerySnapshot snapshot = await _collectionRef.get();

  final data = snapshot.docs;
  for (int i = 0; i < data.length; i++){
    agentIdArr.add(data[i]["agent_id"].toString());
    allAgents.add(AgentModel(
        data[i].reference.id,
        data[i]["location"].toString(),
        data[i]["fname"].toString(),
        data[i]["lname"].toString(),
        data[i]["agent_id"].toString(),
        int.parse(data[i]["rentals_cy"].toString()),
        int.parse(data[i]["wfi_gtl_rentals"].toString()),
        double.parse(data[i]["wfi_gtl_revenues"].toString()),
        double.parse(data[i]["penetration_rate"].toString() == "NaN"? "0.00" : data[i]["penetration_rate"].toString())
    ));
  }
  //print(allAgents.toString());
  context.read<HomePageProvider>().setIsLoadingFalse();
}