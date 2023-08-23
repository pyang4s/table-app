import 'package:flutter/material.dart';

import '../constants/strings.dart';

class BulkUpdatesProvider extends ChangeNotifier{
  late String _fileName = '';
  late String _uploadError = "";

  String get fileName => _fileName;
  String get uploadError => _uploadError;

  void setFileName(String selectedFile){
    _fileName = selectedFile;
    notifyListeners();
  }

  void setNullFileName(){
    _fileName = '';
    notifyListeners();
  }

  void setUploadErrorMessage(){
    _uploadError = anErrorOccurredWhileUploading;
    notifyListeners();
  }
}