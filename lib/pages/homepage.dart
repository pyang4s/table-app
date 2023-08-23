import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test23/providers/home_page_provider.dart';
import '../constants/strings.dart';
import '../constants/global_variables.dart';
import '../methods/csv filing methods/export_agent_data.dart';
import '../widgets/app_bar_widgets/app_bar.dart';
import '../methods/firestore methods/get_firestore_data_method.dart';
import '../widgets/ui_widgets/filter_text_field_widgets.dart';
import '../widgets/ui_widgets/header_buttons.dart';
import '../widgets/ui_widgets/list_view_widget.dart';
import '../widgets/show_dialogs_widgets/bulk_updates_alert_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override

  void initState() {
    super.initState();
    context.read<HomePageProvider>().setIconDefault();
    // at the beginning, load all agents from firebase and all users are shown
    getDataFromFireStore(context);
    context.read<HomePageProvider>().foundAllAgent();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            title: Text(title),
            actions:  const [AppBarActions()],
            automaticallyImplyLeading: false
        ),
        body: Container(
            alignment: Alignment.topCenter,
            child: SizedBox(
                width: width * .93,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        /// Filter Search text boxes
                        SizedBox(
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Row(
                              children:  [
                                filterTextFieldWidget(locationDoc, locationVis, context),
                                filterTextFieldWidget(agentNameDoc, agentNameVis, context),
                                filterTextFieldWidget(agentIdDoc, agentIdVis, context),
                                filterTextFieldWidget(rentalsCyDoc, rentalsCyVis, context),
                                filterTextFieldWidget(wfiGtlRentalsDoc, wfiGtlRentalsVis, context),
                                filterTextFieldWidget(wfiGtlRevenuesDoc, wfiGtlRevenuesVis, context),
                                filterTextFieldWidget(penetrationRateDoc, penetrationRateVis, context),
                              ],
                            ),
                          ),
                        ),
                        /// Column header buttons with ability to sort data
                        SizedBox(
                          child: Row(
                            children:  [
                              headerButtons(locationHeader, locationDoc, locationVis, context),
                              headerButtons(agentNameHeader, agentNameDoc, agentNameVis, context),
                              headerButtons(agentIdHeader, agentIdDoc, agentIdVis, context),
                              headerButtons(availableRentals, rentalsCyDoc, rentalsCyVis, context),
                              headerButtons(totalRented, wfiGtlRentalsDoc, wfiGtlRentalsVis, context),
                              headerButtons(rentalRevenue, wfiGtlRevenuesDoc, wfiGtlRevenuesVis, context),
                              headerButtons(rentalRate, penetrationRateDoc, penetrationRateVis, context),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: context.watch<HomePageProvider>().isLoading == true? Transform.scale(
                              scale: 5,
                              child: const CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.blue,
                                strokeWidth: 100,
                              )
                          ): listViewWidget(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('Total Agents: ' + allAgents.length.toString()),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        /// this widget contains the bulk update action buttons
                        Row(
                          children: [
                            const Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () =>
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) => const ImportData()),
                                child: Row(
                                  children: const [
                                    Text('Import '),
                                    Icon(Icons.upload_sharp)
                                  ],
                                )
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  exportAgentData();
                                },
                                child: Row(
                                  children: const [
                                    Text('Export '),
                                    Icon(Icons.download_sharp)
                                  ],
                                )
                            ),
                          ],
                        ),
                      ]
                  ),
                )
            )
        )
    );
  }
}

