import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  static String hrmApiUrl = 'http://localhost:8080';
  static String hrmApiKey = '';
  static String choreoSTSEndpoint = "https://sts.choreo.dev/oauth2/token";
  static String choreoSTSClientID = "Mhss_8Q4iuJ83Tt2Mtazju8MltYa";
  static var apiTokens = null;
  static String applicationName = 'AF HRMS Admin Portal';
  static String applicationVersion = '0.3.0';

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
