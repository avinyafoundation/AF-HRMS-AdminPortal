import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  static String hrmApiUrl = 'http://localhost:8080';
  static String hrmApiKey = '';

  //AppConfig({required this.apiUrl});

  static Future<AppConfig> forEnvironment(String env) async {
    // load the json file
    String contents = "{}";
    try {
      contents = await rootBundle.loadString(
        'assets/config/$env.json',
      );
    } catch (e) {
      print(e);
    }

    // decode our json
    final json = jsonDecode(contents);
    hrmApiUrl = json['hrm_api_url'];
    hrmApiKey = json['hrm_api_key'];

    // convert our JSON into an instance of our AppConfig class
    return AppConfig();
  }

  String getApiUrl() {
    return hrmApiUrl;
  }
}
