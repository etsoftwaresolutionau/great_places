import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum RequestType { GET, POST, DELETE }
// Map loggedInUser = {};

class ApiHelper {
  static final String API = "http://54.66.252.33/api/";
  String lastError = "";
  
  static Future<dynamic> getData(String url,
      {bool hasAuth = false, BuildContext context}) async {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    String endpoint = url;
    Map<String, String> headers;   
    
    // if (hasAuth) {
    //   headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    // }
    // return;

    final response = await http.get(endpoint, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return data;
    }
  }

  static Future<dynamic> postData(String url, dynamic data,
      {bool hasAuth = false, BuildContext context}) async {
    String endpoint = url;
  
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    // if (hasAuth) {
    //   var token = getLoggedInUser()['api_token'];
    //   headers = {
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     HttpHeaders.authorizationHeader: "Bearer $token"
    //   };
    // }

    try {
      final response = await http.post(
        endpoint,
        body: json.encode(data),
        headers: headers,
      );
      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      }

      if (response.statusCode == 200) {
        if (response.body == "") {
          return "";
        } else {
          var data = json.decode(response.body);
          return data;
        }
      }     
    } on FormatException catch (f) {
      print("exception");
      print(f);
      // this.lastError = f.message + " : " + f.source;
      //this.showToastError("Error Occured");
    } on Exception catch (e) {
      print(e.toString());
      // this.lastError = "Unexpected Error";
      //this.showToastError("Error Occured");
    }
  }

  static Future<dynamic> putData(String url, dynamic data,
      {bool hasAuth = true}) async {
    String endpoint = url;
    
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    // if (hasAuth) {
    //   var token = getLoggedInUser()['api_token'];
    //   headers = {
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     HttpHeaders.authorizationHeader: "Bearer $token"
    //   };
    // }

    try {
      final response = await http.put(
        endpoint,
        body: json.encode(data),
        headers: headers,
      );
      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      }

      if (response.statusCode == 200) {
        if (response.body == "") {
          return "";
        } else {
          var data = json.decode(response.body);
          return data;
        }
      } else {
        var body = json.decode(response.body);
        // this.lastError = body['message'];
        print(body['message']);
        return null;
      }
    } on FormatException catch (f) {
      print("exception");
      print(f);
      // this.lastError = f.message + " : " + f.source;
      //this.showToastError("Error Occured");
    } on Exception catch (e) {
      // this.lastError = "Unexpected Error";
      // this.showToastError("Error Occured");
    }
  } 
}
