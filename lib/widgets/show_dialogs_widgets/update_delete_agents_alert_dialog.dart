import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test23/providers/agent_state_provider.dart';
import '../../constants/global_variables.dart';
import '../../constants/strings.dart';
import '../../models/agent_model.dart';
import '../../providers/home_page_provider.dart';
import '../snackbar_widgets/pass_fail_snackbars.dart';

class UpdateDeleteAlert extends StatefulWidget {
  final String agentRefId;
  final String location;
  final String firstName;
  final String lastName;
  final String agentId;
  final int rentalsCy;
  final int wfiGtlRentalsCy;
  final double wfiGtlRevenuesCy;
  final double penetrationRate;

  const UpdateDeleteAlert(
      this.agentRefId,
      this.location,
      this.firstName,
      this.lastName,
      this.agentId,
      this.rentalsCy,
      this.wfiGtlRentalsCy,
      this.wfiGtlRevenuesCy,
      this.penetrationRate
      ) ;

  @override
  State<UpdateDeleteAlert> createState() => _UpdateDeleteAlertState();
}

class _UpdateDeleteAlertState extends State<UpdateDeleteAlert> {

  @override
  initState(){
    super.initState();
    agentObject = AgentModel(
        widget.agentRefId,
        widget.location,
        widget.firstName,
        widget.lastName,
        widget.agentId,
        widget.rentalsCy,
        widget.wfiGtlRentalsCy,
        widget.wfiGtlRevenuesCy,
        widget.penetrationRate
    );

    agentFirstNameCtlr.text = agentObject.getFirstNameAsString();
    agentLastNameCtlr.text = agentObject.getLastNameAsString();
    agentIdCtlr.text = agentObject.getAgentIdAsString();
    rentalsCyCtlr.text = agentObject.getRentalsCyAsString();
    wfiGtlRentalsCtlr.text = agentObject.getWfiGtlRentalsAsString();
    wfiGtlRevenuesCtlr.text = agentObject.getWfiGtlRevenuesAsString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Agent Information', textAlign: TextAlign.center),
        content: SizedBox(
            width: 700,
            height: 210,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                          height: 30,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    style: const TextStyle(fontSize: 12),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      context.read<AgentStateProvider>().setSelectedValue(value);
                                    },
                                    items: dropDownItems,
                                  )
                              )
                          ),
                        )
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                        child: SizedBox(
                          height: 30,
                          child: TextField(
                            controller: agentFirstNameCtlr,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelStyle: const TextStyle(fontSize: 12),
                              labelText: "$firstNameHeader*",
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                    ),
                    Expanded(
                        child: SizedBox(
                          height: 30,
                          child: TextField(
                            controller: agentLastNameCtlr,
                            decoration:  InputDecoration(
                              border: const OutlineInputBorder(),
                              labelStyle: const TextStyle(fontSize: 12),
                              labelText: "$lastNameHeader*",
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                        child: SizedBox(
                          height: 30,
                          child: TextField(
                            controller: agentIdCtlr,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: const TextStyle(fontSize: 12),
                                labelText: '$agentIdHeader*"'
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                          height: 30,
                          child: TextField(
                            controller: rentalsCyCtlr,
                            decoration:  InputDecoration(
                              border: const OutlineInputBorder(),
                              labelStyle: const TextStyle(fontSize: 12),
                              labelText: rentalsCyHeader,
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                    ),
                    const SizedBox(width: 5),

                    Expanded(
                        child: SizedBox(
                          height: 30,
                          child: TextField(
                            controller: wfiGtlRentalsCtlr,
                            decoration:  InputDecoration(
                              border: const OutlineInputBorder(),
                              labelStyle: const TextStyle(fontSize: 12),
                              labelText: wfiGtlRentalsHeader,
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                        child: SizedBox(
                          height: 30,
                          child: TextField(
                            controller: wfiGtlRevenuesCtlr,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelStyle: const TextStyle(fontSize: 12),
                                labelText: wfiGtlRevenuesHeader
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                        )
                    ),
                  ],
                ),
                Text(
                    context.watch<AgentStateProvider>().error,
                    style:  const TextStyle(color: Colors.red)
                ),
              ],
            )

        ),

        actions: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: (){
                //initializing variables for agent obj
                addAgentFirstName = agentFirstNameCtlr.text;
                addAgentLastName = agentLastNameCtlr.text;
                addAgentId = agentIdCtlr.text;
                if (rentalsCyCtlr.text.replaceAll(",", "").trim().isEmpty){
                  addRentalsCy = "0";
                } else {
                  addRentalsCy = rentalsCyCtlr.text.replaceAll(",", "").trim().toString();
                }
                if (wfiGtlRentalsCtlr.text.replaceAll(",", "").trim().isEmpty){
                  addWfiGtlRentalsCy = "0";
                } else {
                  addWfiGtlRentalsCy = wfiGtlRentalsCtlr.text.replaceAll(",", "").trim();
                }
                if(wfiGtlRevenuesCtlr.text.replaceAll("\$", '').replaceAll(",", "").trim().isEmpty){
                  addWfiGtlRevenuesCy = "0.00";
                } else {
                  addWfiGtlRevenuesCy = wfiGtlRevenuesCtlr.text.replaceAll("\$", '').replaceAll(",", "").trim();
                }
                updateAgent(context);
              },
              child: const Text("Update")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: (){
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text('Confirm Deletion', textAlign: TextAlign.center,),
                          content: SizedBox(
                            height: 100,
                            width: 150,
                            child: Column(
                              children: [
                                Text(
                                    "Agent ${agentObject.getFullName()} will be permanently deleted",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 14)),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    ElevatedButton(
                                        onPressed: (){
                                          agentFirstNameCtlr.clear();
                                          agentLastNameCtlr.clear();
                                          agentIdCtlr.clear();
                                          rentalsCyCtlr.clear();
                                          wfiGtlRevenuesCtlr.clear();
                                          wfiGtlRentalsCtlr.clear();
                                          context.read<AgentStateProvider>().defaultMessage();
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel")
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        onPressed: (){
                                          agentObject.deleteAgent(agentObject.getAgentRefIdAsString());
                                          context.read<HomePageProvider>().foundAllAgent();
                                          showSnackBarSuccess(ScaffoldMessenger.of(context), 'Agent has been Deleted');
                                          Navigator.pop(context); // pop first time to close 2nd alert box
                                          Navigator.pop(context); //pop second time to close 1st alert box
                                        },
                                        child: const Text("Confirm")
                                    ),
                                    const Spacer()
                                  ],
                                )
                              ],
                            ),
                          )
                      );
                    });
              },
              child: const Text("Delete")),
        ]
    );
  }
}


/// This method updates an agent if the update button is clicked
///
updateAgent(BuildContext context){

  String agentRefId = agentObject.getAgentRefIdAsString();
  context.read<AgentStateProvider>().defaultMessage();
  addLocation = selectedValue;
  //Conditioning
  if(addAgentFirstName.isEmpty || addAgentLastName.isEmpty){
    context.read<AgentStateProvider>().emptyNameMessage();
  }
  if( addAgentId.isEmpty){
    context.read<AgentStateProvider>().emptyIdMessage();
  }
  if(addAgentId.isNotEmpty){
    if (agentObject.getAgentIdAsString() != addAgentId){
      for (var agent in allAgents){
        if (agent.getAgentIdAsString() == addAgentId){
          context.read<AgentStateProvider>().agentIdAlreadyExistsMessage(agent);
          break;
        }
      }
    }
  }
  if(int.tryParse(addRentalsCy) == null){
    context.read<AgentStateProvider>().rentalsCyNotWholeMessage();
  }
  if (int.tryParse(addWfiGtlRentalsCy) == null){
    context.read<AgentStateProvider>().wfiGtlRentalsNotWholeMessage();
  }
  if (double.tryParse(addWfiGtlRevenuesCy) == null){
    context.read<AgentStateProvider>().wfiGtlRevenuesNotNumMessage();
  }
  if (int.tryParse(addRentalsCy) != null && int.tryParse(addWfiGtlRentalsCy)!= null){
    if (int.parse(addWfiGtlRentalsCy) > int.parse(addRentalsCy)){
      context.read<AgentStateProvider>().wfiGtlRentalsExceedsMessage();
    } else {
      if(int.parse(addWfiGtlRentalsCy) == int.parse(addRentalsCy)) {
        addPenetrationRate = 0.00;
      } else {
        addPenetrationRate = (int.parse(addWfiGtlRentalsCy)/int.parse(addRentalsCy))*100;
      }
    }
  }

  // If no error was found, then process data
  if (errorMessage.trim().isEmpty){
    agentObject = AgentModel(
        agentRefId,
        addLocation,
        addAgentFirstName,
        addAgentLastName,
        addAgentId,
        addRentalsCy,
        addWfiGtlRentalsCy,
        addWfiGtlRevenuesCy,
        addPenetrationRate
    );

    agentObject.updateAgent(agentRefId);
    showSnackBarSuccess(ScaffoldMessenger.of(context), 'Agent has been Updated');
    context.read<HomePageProvider>().foundAllAgent();
    Navigator.pop(context);
  }
}