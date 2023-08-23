import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/global_variables.dart';
import '../../constants/strings.dart';
import '../../providers/agent_state_provider.dart';
import '../../models/agent_model.dart';
import '../../providers/home_page_provider.dart';
import '../snackbar_widgets/pass_fail_snackbars.dart';


///This widget is use to add agents to firebase
///
/// It will automatically reflect on the web app
class AlertAddAgent extends StatefulWidget {
  const AlertAddAgent({Key? key}) : super(key: key);

  @override
  State<AlertAddAgent> createState() => _AlertAddAgentState();
}

class _AlertAddAgentState extends State<AlertAddAgent> {
  //Controllers for user input
  final agentFirstNameCtlr = TextEditingController();
  final agentLastNameCtlr = TextEditingController();
  final agentIdCtlr = TextEditingController();
  final rentalsCyCtlr = TextEditingController();
  final wfiGtlRentalsCtlr = TextEditingController();
  final wfiGtlRevenuesCtlr = TextEditingController();

  //Variables to hold user input for agent add
  late String addLocation;
  late String addAgentFirstName;
  late String addAgentLastName;
  late String addAgentId;
  late String? addRentalsCy;
  late String? addWfiGtlRentalsCy;
  late String? addWfiGtlRevenuesCy;
  late double addPenetrationRate;

//Objects
  late AgentModel addAgentModel;

  @override
  initState() {
    super.initState();
    addLocation = "ABQ";
  }

  @override
  Widget build(BuildContext context) {


    /// When the Add Agent button is clicked, this alert dialog will appear
    ///
    /// Upon missing required elements, an error message will appear
    /// Upon successful add, the new agent will show up on the web app
    return AlertDialog(
      title: const Text('Add Agent', textAlign: TextAlign.center,),
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
                                  onChanged: (value) =>
                                      context.read<
                                          AgentStateProvider>()
                                          .setSelectedValue(value),
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'First Name*',
                              labelStyle: TextStyle(fontSize: 12)
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name*',
                              labelStyle: TextStyle(fontSize: 12)
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Agent ID*',
                              labelStyle: TextStyle(fontSize: 12)
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Rentals CY',
                              labelStyle: TextStyle(fontSize: 12)
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'WFI/GTL Rentals',
                              labelStyle: TextStyle(fontSize: 12)
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
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'WFI/GTL Revenues',
                              labelStyle: TextStyle(fontSize: 12)
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 5),
              Center(
                child: SizedBox(
                  width: 350,
                  child: Text(
                      context
                          .watch<AgentStateProvider>()
                          .error,
                      style: const TextStyle(color: Colors.red, fontSize: 14)),
                ),
              )
            ],
          )
      ),
      actions: <Widget>[

        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              agentFirstNameCtlr.clear();
              agentLastNameCtlr.clear();
              agentIdCtlr.clear();
              rentalsCyCtlr.clear();
              wfiGtlRevenuesCtlr.clear();
              wfiGtlRentalsCtlr.clear();
              context.read<AgentStateProvider>().defaultMessage();
            },
            child: const Text('Cancel')),
        const SizedBox(width: 5),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          onPressed: () async {
            //initializing variables for agent obj
            addLocation = selectedValue;
            addAgentFirstName = agentFirstNameCtlr.text;
            addAgentLastName = agentLastNameCtlr.text;
            addAgentId = agentIdCtlr.text;
            if (rentalsCyCtlr.text
                .replaceAll(",", "")
                .trim()
                .isEmpty) {
              addRentalsCy = "0";
            } else {
              addRentalsCy =
                  rentalsCyCtlr.text.replaceAll(",", "").trim().toString();
            }
            if (wfiGtlRentalsCtlr.text
                .replaceAll(",", "")
                .trim()
                .isEmpty) {
              addWfiGtlRentalsCy = "0";
            } else {
              addWfiGtlRentalsCy =
                  wfiGtlRentalsCtlr.text.replaceAll(",", "").trim();
            }
            if (wfiGtlRevenuesCtlr.text
                .replaceAll("\$", '')
                .replaceAll(",", "")
                .trim()
                .isEmpty) {
              addWfiGtlRevenuesCy = "0.00";
            } else {
              addWfiGtlRevenuesCy =
                  wfiGtlRevenuesCtlr.text.replaceAll("\$", '').replaceAll(
                      ",", "").trim();
            }

            addAgent(context, addLocation, addAgentFirstName, addAgentLastName, addAgentId, addRentalsCy, addWfiGtlRentalsCy, addWfiGtlRevenuesCy);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}


addAgent(BuildContext context, String addLocation, String addAgentFirstName, String addAgentLastName, String addAgentId, String? addRentalsCy, String? addWfiGtlRentalsCy, String? addWfiGtlRevenuesCy) {
  late AgentModel agentObj;

  context.read<AgentStateProvider>().defaultMessage();
  //Conditioning
  if (addAgentFirstName.isEmpty || addAgentLastName.isEmpty) {
    context.read<AgentStateProvider>().emptyNameMessage();
  }
  if (addAgentId.isEmpty) {
    context.read<AgentStateProvider>().emptyIdMessage();
  }

  if (addAgentId.isNotEmpty) {
    for (var agent in allAgents) {
      if (agent.getAgentIdAsString() == addAgentId) {
        context.read<AgentStateProvider>().agentIdAlreadyExistsMessage(agent);
        break;
      }
    }
  }

  if (int.tryParse(addRentalsCy!) == null) {
    context.read<AgentStateProvider>().rentalsCyNotWholeMessage();
  }

  if (int.tryParse(addWfiGtlRentalsCy!) == null) {
    context.read<AgentStateProvider>().wfiGtlRentalsNotWholeMessage();
  }


  if (double.tryParse(addWfiGtlRevenuesCy!) == null) {
    context.read<AgentStateProvider>().wfiGtlRevenuesNotNumMessage();
  }

  if (int.tryParse(addWfiGtlRentalsCy) != null &&
      int.tryParse(addRentalsCy) != null) {
    if (int.parse(addWfiGtlRentalsCy) > int.parse(addRentalsCy)) {
      context.read<AgentStateProvider>().wfiGtlRentalsExceedsMessage();
    } else {
      addPenetrationRate =
          (int.parse(addWfiGtlRentalsCy) / int.parse(addRentalsCy)) * 100;
    }
  }
  if (addPenetrationRate.toString() == "NaN") {
    addPenetrationRate = 0.0;
  }

  /// If there is no error in the data provided, then proceed with adding agent
  if (errorMessage
      .trim()
      .isEmpty) {
    agentObj = AgentModel(
        "N/A",
        addLocation,
        addAgentFirstName,
        addAgentLastName,
        addAgentId,
        addRentalsCy,
        addWfiGtlRentalsCy,
        addWfiGtlRevenuesCy,
        addPenetrationRate
    );

    agentObj.add();
    // Set all found agents to all agents
    context.read<HomePageProvider>().foundAllAgent();

    // show success snackBar
    showSnackBarSuccess(
        ScaffoldMessenger.of(context), 'Agent has been Added');

    //clear all fields
    agentFirstNameCtlr.clear();
    agentLastNameCtlr.clear();
    agentIdCtlr.clear();
    rentalsCyCtlr.clear();
    wfiGtlRevenuesCtlr.clear();
    wfiGtlRentalsCtlr.clear();

    //close alert box
    Navigator.pop(context);
  } else {
    if (kDebugMode) {
      print(errorMessage);
    }
  }
}