import 'package:flutter/material.dart';

columnData(String data){
  return  Material(
    elevation: 1,
    child: SizedBox(

        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Text(
            data,
            style:  const TextStyle(color: Colors.black, fontSize: 14, backgroundColor: Colors.transparent),
            textAlign: TextAlign.justify,
          ),
        )
    ),
  );
}