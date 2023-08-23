import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../show_dialogs_widgets/add_agent_alert_dialog.dart';

///This widget contains elements in the app bar
class AppBarActions extends StatefulWidget {
  const AppBarActions({Key? key}) : super(key: key);

  @override
  State<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends State<AppBarActions> {

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Theme(
            data: Theme.of(context).copyWith(
              backgroundColor: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                    elevation: 10,
                  shadowColor: Colors.black
                ),
                onPressed: (){
                  //print("IDs: " + agentIdArr.toString());
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context)
                      {
                        return const AlertAddAgent();
                      }
                  );
                },
                child: const Icon(CupertinoIcons.plus),
              ),
            )
        )
    );
  }
}
