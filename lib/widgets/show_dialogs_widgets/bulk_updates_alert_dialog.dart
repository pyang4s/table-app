import 'dart:core';
import 'package:provider/provider.dart';
import 'package:test23/providers/bulk_updates_provider.dart';
import 'package:flutter/material.dart';
import '../../methods/csv filing methods/download_template.dart';
import '../../methods/csv filing methods/pick_csv_file.dart';
import '../../methods/csv filing methods/process_csv_file.dart';

///This widget contains import implementations
class ImportData extends StatefulWidget {
  const ImportData({Key? key}) : super(key: key);

  @override
  State<ImportData> createState() => _ImportDataState();
}

class _ImportDataState extends State<ImportData> {
  List<List<dynamic>> agentData = [];

  @override
  void initState() {
    super.initState();
    agentData  = List<List<dynamic>>.empty(growable: true);
  }
  @override
  Widget build(BuildContext context) {
    const errorText = "";

    return AlertDialog(
      content: SizedBox(
          height: 185,
          child: Column(
              children: [
                const Text(
                    "Import Agent Data (CSV)",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue)),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      elevation: 2
                  ),
                  onPressed: () {
                    //_openFileExplorer();
                    pickCsvFile(context);
                  },
                  child: const Text("[Upload File]"),
                ),
                const SizedBox(height: 15),
                Text(context.watch<BulkUpdatesProvider>().fileName),
                const Divider(
                  height: 5,
                  thickness: 1,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () {
                          context.read<BulkUpdatesProvider>().setNullFileName();
                          Navigator.pop(context);

                        },
                        child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white))),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: (){
                          print("uploading csv file");
                          var fileName = context.read<BulkUpdatesProvider>().fileName;
                          fileName == "" ? context.read<BulkUpdatesProvider>().setNoFileLoadedErrorMessage(): processCsvFile(context);
                        },
                        child: const Text("Submit")),
                    const Spacer(),
                  ],
                ),
          const SizedBox(height: 10),
          TextButton(
                    onPressed: () {
                      downLoadTemplate();
                     // print(agentData[0]);
                    },
                    child: const Text(
                        "Download template",
                        style: TextStyle(color: Colors.black))),
                Text(context.read<BulkUpdatesProvider>().uploadError, style: const TextStyle(color: Colors.red),)
              ]
          )
      ),
    );
  }
}




