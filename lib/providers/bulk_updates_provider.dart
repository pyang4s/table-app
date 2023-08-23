import 'package:flutter/material.dart';

import '../constants/strings.dart';

class BulkUpdatesProvider extends ChangeNotifier{
  late String _fileName = '';
  late String _uploadError = "";
  late List<int> _fileByte = [];

  String get fileName => _fileName;
  String get uploadError => _uploadError;
  List<int> get fileBytes => _fileByte;

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

  void setNoFileLoadedErrorMessage(){
    _uploadError = "No file selected";
    notifyListeners();
  }

  void setFileBytes(selectedFile){
    _fileByte = selectedFile;
    notifyListeners();
  }
}