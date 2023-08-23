
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/global_variables.dart';
import '../../models/agent_model.dart';
import '../../providers/home_page_provider.dart';

/// this method returns a widget
filterTextFieldWidget(String docName, bool isVisible, BuildContext context){
  return Expanded(
    child: Visibility(
      visible: isVisible,
      child: Center(
        child: TextField(
          onChanged: (value) => runFilter(docName, value, context),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, bottom: 5),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              )),
        ),
      ),
    ),
  ); 
}


/// This method is called whenever the text field changes
runFilter(String columnName, String enteredKeyword, BuildContext context){
  List<AgentModel> results = [];
  if (enteredKeyword.isEmpty) {
    // if the search field is empty or only contains white-space, we'll display all users
    results = allAgents;
  } else {
    results = allAgents
        .where((column) =>
        column.getFilter(columnName).toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    // we use the toLowerCase() method to make it case-insensitive
  }
  context.read<HomePageProvider>().filterFoundAgents(results);
}