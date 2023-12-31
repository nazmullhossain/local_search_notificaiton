import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import '../model/doctor_model.dart';

class DoctorListService {
  Future<List<Data>> getDoctorList(BuildContext context) async {
    List<Data> insertDoctorList = [];

    try {

      final String url = "http://skinvd.itmapi.com/api/doctor/list";

      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer 141|e81hoIXtG52xjpr5ujEZhZhOZcN4m1qoqtqoZCZE"
      };

      http.Response res = await http.get(Uri.parse(url), headers: headers);
      print("get data${res.body}");
      print("get brandddddddddddddddddddd       ${res.body.length}");

      if (res.statusCode == 200) {
        var jsonRes = jsonDecode(res.body);

        print(jsonRes);

        DoctorModel brandModel = DoctorModel.fromJson(jsonRes);

        for (Data data in brandModel.data!) {
          insertDoctorList.add(data);

        }
      }
    } on SocketException {
      Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print(e.toString());
    }
    return insertDoctorList;
  }
}