import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test23/providers/home_page_provider.dart';
import '../../constants/global_variables.dart';
import '../../constants/strings.dart';
import 'package:collection/collection.dart';
import 'package:test23/constants/strings.dart';
import '../../../models/agent_model.dart';

/// This method returns a widget
headerButtons(String headerName, String docName, bool filterVis, BuildContext context){


  return Expanded(
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
        onLongPress: (){
          if (filterVis == true){
            context.read<HomePageProvider>().hideAllTextField();
          } else {
            context.read<HomePageProvider>().showTextField(docName);
          }
        },
        onPressed: () {
          sortData(docName, context, foundAgents);
        },
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                headerName,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.left,
                softWrap: false,
              ),
              const SizedBox(width: 100),
              Visibility(
                // show icon as visible for the column that is sorted
                visible: (foundAgents.isSorted((a, b) => a.getSort(docName).compareTo(
                    b.getSort(docName))) == true ||
                    foundAgents.isSorted((b, a) => a.getSort(docName).compareTo(
                    b.getSort(docName))) == true ||
                    foundAgents.isSorted((a, b) =>
                        a.getSort(docName).toString().toLowerCase().compareTo(
                            b.getSort(docName).toString().toLowerCase())) ||
                    foundAgents.isSorted((b, a) =>
                        a.getSort(docName).toString().toLowerCase().compareTo(
                            b.getSort(docName).toString().toLowerCase())))? true : false,
                child: context.watch<HomePageProvider>().sortIcon,
              ),
            ],
          )
        )
    ),
  );
}

/// This method is called when header button is clicked
///
/// sort either ascending or descending
sortData(String dataName, BuildContext context, List<AgentModel> list){
  if (dataName == locationDoc || dataName == agentNameDoc || dataName == agentIdDoc) {
    if (list.isSorted((a, b) =>
        a.getSort(dataName).toString().toLowerCase().compareTo(
            b.getSort(dataName).toString().toLowerCase()))) {
      context.read<HomePageProvider>().sortDescending(dataName);
    } else {
      context.read<HomePageProvider>().sortAscending(dataName);
    }
  } else {
    if (list.isSorted((a, b) =>
        a.getSort(dataName).compareTo(
            b.getSort(dataName)))) {
      context.read<HomePageProvider>().sortDescending(dataName);
    } else {
      context.read<HomePageProvider>().sortAscending(dataName);
    }
  }
}
