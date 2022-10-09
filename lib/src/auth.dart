import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:flutter/widgets.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import './config/app_config.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

/// A mock authentication service
class SMSAuth extends ChangeNotifier {
  bool _signedIn = false;
  var _openid_tokens;

  Future<bool> getSignedIn() async {
    var tokens = window.localStorage['openid_client:tokens'];

    if (tokens != null) {
      _openid_tokens = json.decode(tokens);

      if (_openid_tokens != null && _openid_tokens['access_token'] != null) {
        _signedIn = true;
        print('OpenID tokens ##################');
        // _openid_tokens
        //     .forEach((key, value) => print("Key : $key, Value : $value"));

        bool isTokenExpired = JwtDecoder.isExpired(_openid_tokens["id_token"]);
        if (isTokenExpired) {
          _signedIn = false;
          return _signedIn;
        }

        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(_openid_tokens["id_token"]);
        decodedToken
            .forEach((key, value) => print("Key : $key, Value : $value"));
        print(decodedToken["name"]);

        if (AppConfig.apiTokens != null) {
          //use refresh token
          // however when app reloads, apiTokens will be null
          // should refresh token when calling APIs
        } else {
          final response = await http.post(
            Uri.parse(AppConfig.choreoSTSEndpoint),
            headers: <String, String>{
              'Content-Type': 'application/x-www-form-urlencoded',
              'API-Key': AppConfig.hrmApiKey,
            },
            encoding: Encoding.getByName('utf-8'),
            body: {
              "client_id": AppConfig.choreoSTSClientID,
              "subject_token_type": "urn:ietf:params:oauth:token-type:jwt",
              "grant_type": "urn:ietf:params:oauth:grant-type:token-exchange",
              "subject_token": _openid_tokens["id_token"],
            },
          );
          if (response.statusCode == 200) {
            print(response.body.toString());
            var _api_tokens = json.decode(response.body);
            AppConfig.apiTokens = _api_tokens;
            print('API tokens ##################');
            _api_tokens
              ..forEach((key, value) => print("Key : $key, Value : $value"));
          } else {
            print('Failed to fetch API key');
            _signedIn = false;
          }
        }
      }
    }

    return _signedIn;
  }

  Future<void> logout() async {
    String logoutUrl = "https://api.asgardeo.io/t/avinyafoundation/oidc/logout";
    if (await canLaunchUrl(Uri.parse(logoutUrl))) {
      await launchUrl(Uri.parse(logoutUrl), mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $logoutUrl';
    }
    await Future.delayed(Duration(seconds: 3));
  }

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    window.localStorage.clear();
    _signedIn = false;
    try {
      await logout();
    } catch (error) {
      log(error.toString());
    }
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // Sign in. Allow any password.
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }

  @override
  bool operator ==(Object other) =>
      other is SMSAuth && other._signedIn == _signedIn;

  @override
  int get hashCode => _signedIn.hashCode;
}

class SMSAuthScope extends InheritedNotifier<SMSAuth> {
  const SMSAuthScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static SMSAuth of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SMSAuthScope>()!.notifier!;
}
