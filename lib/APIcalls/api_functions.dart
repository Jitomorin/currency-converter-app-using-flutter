import 'dart:convert';
import 'dart:developer';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class APIFunctions {
  // ignore: non_constant_identifier_names
  final String APIKey = 'TVh9rqImuanSAmjfY35O3ftIQGG7ii0eaHCjrkov';
  final String endpointURL = 'api.freecurrencyapi.com/v1/latest';
  //https://api.freecurrencyapi.com/v1/latest?apikey=TVh9rqImuanSAmjfY35O3ftIQGG7ii0eaHCjrkov&currencies=EUR%2CUSD%2CCAD
  //&currencies=EUR%2CUSD%2CCAD
  fetchCurrency() async {
    Map<String, String> queryParams = {
      'apikey': APIKey,
    };
    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = '$endpointURL?$queryString';
    /* var response = await http.get(Uri.https(
      'api.freecurrencyapi.com',
      'v1/latest',
    )); */
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      log('response: $data');
    } else {
      throw Exception('Failed to load currency');
    }
  }
}
