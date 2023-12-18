import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static String phoneProdURL = "https://rest.monex.com";
  static String phoneTestURL = "https://rest.monex.com/test";
  static String emulatorURL = "http://10.10.16.146:8080";
  static String activeURL = phoneTestURL;

  static Future<void> login(String userName, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }
  // static Future<WebAuthenticationModel> login(String userName, String password) async {
  //   Map<String, String> headers = {"Content-Type": "application/json"};
  //   String body = '{"userName" : "$userName", "password" : "$password"}';
  //
  //   http.Response response = await http.post(Uri.parse(activeURL + "/api/v1/login"), headers: headers, body: body);
  //   if (response.statusCode == 200) {
  //     // If server returns an OK response, parse the JSON.
  //     try {
  //       Map<String, dynamic> map = json.decode(response.body);
  //       return WebAuthenticationModel.fromJson(json.decode(response.body));
  //     } on FormatException {
  //       // Could not parse JSON object, most likely a null was returned, indicating
  //       // that the User submitted bad credentials.
  //       //return null;
  //       throw Exception('Failed to load post');
  //     }
  //   } else {
  //     // If that response was not OK, throw an error.
  //     throw Exception('Failed to load post');
  //     //return null;
  //   }
  // }

  static Future<bool> createCredentials(String accountNumber, String emailAddress) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    String url = "$activeURL/api/v2/setup?acctNum=$accountNumber&emailAddr=$emailAddress";
    http.Response response = await http.post(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If that response was not OK, throw an error.
      throw Exception(response.body);
    }
  }

  static Future<void> changePassword(int id, String password) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    String url = "$activeURL/api/v2/password/$id/$password";
    http.Response response = await http.post(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      // If that response was not OK, throw an error.
      throw Exception(response.body);
    }
  }

  static Future<void> changeUserId(int id, String userName) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    String url = "$activeURL/api/v2/saveuserid?id=$id&userName=$userName";
    http.Response response = await http.post(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      // If that response was not OK, throw an error.
      throw Exception(response.body);
    }
  }
}
