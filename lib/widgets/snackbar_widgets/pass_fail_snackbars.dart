
import 'package:flutter/material.dart';


showSnackBarSuccess(ScaffoldMessengerState currentPage, String message){
  var snackBar = SnackBar(backgroundColor: Colors.green, content: Text(message));
  return currentPage.showSnackBar(snackBar);
}

showSnackBarFailure(ScaffoldMessengerState currentPage, String message){
  var snackBar = SnackBar(backgroundColor: Colors.red, content: Text(message));
  return currentPage.showSnackBar(snackBar);
}