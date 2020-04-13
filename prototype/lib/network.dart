import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  Future getData() async{
    http.Response response = await http.get('http://10.0.2.2:8000/products/?format=json');
    if(response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    }else{
      print(response.statusCode);
    }
  }
}
//http://10.0.2.2:8000/products/1/?format=json