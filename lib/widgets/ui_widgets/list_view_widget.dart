
import 'package:flutter/material.dart';
import 'package:test23/widgets/show_dialogs_widgets/update_delete_agents_alert_dialog.dart';
import '../../constants/global_variables.dart';
import 'column_data.dart';

listViewWidget(){
  return ListView.builder(
      itemCount: foundAgents.length,
      itemBuilder: (context, index) {
        return TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              //print('Column $index was pressed with refId ${foundAgents[index].getAgentRefIdAsString()}');
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      UpdateDeleteAlert(
                          foundAgents[index].getAgentRefIdAsString(),
                          foundAgents[index].getLocationAsString(),
                          foundAgents[index].getFirstNameAsString(),
                          foundAgents[index].getLastNameAsString(),
                          foundAgents[index].getAgentIdAsString(),
                          foundAgents[index].getRentalsCyAsInt(),
                          foundAgents[index].getWfiGtlRentalsAsInt(),
                          foundAgents[index].getWfiGtlRevenuesAsDouble(),
                          foundAgents[index].getPenetrationRateAsDouble())
              );
            },
            child: Row(
              children: [
                Expanded(
                    child: columnData(foundAgents[index].getLocationAsString())
                ),
                Expanded(
                    child: columnData(foundAgents[index].getFullName())
                ),
                Expanded(
                    child: columnData(foundAgents[index].getAgentIdAsString())
                ),
                Expanded(
                    child: columnData(foundAgents[index].getRentalsCyAsString())
                ),
                Expanded(
                    child: columnData(foundAgents[index].getWfiGtlRentalsAsString())
                ),
                Expanded(
                    child: columnData(foundAgents[index].getWfiGtlRevenuesAsString())
                ),
                Expanded(
                    child: columnData(foundAgents[index].getPenetrationRateAsString())
                ),
              ],
            )
        );
      }
  );
}