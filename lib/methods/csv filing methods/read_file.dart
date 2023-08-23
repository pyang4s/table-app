import 'dart:convert';
import 'package:csv/csv.dart';
import '../../constants/global_variables.dart';

///
/// This method reads bytes from CSV files and turns them into strings
///
readCsvFile(List<int> csvBytes){
  String csvString = utf8.decode(csvBytes);
  fromCsvList = const CsvToListConverter().convert(csvString);
}