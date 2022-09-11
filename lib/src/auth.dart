import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:flutter/widgets.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

/// A mock authentication service
class SMSAuth extends ChangeNotifier {
  bool _signedIn = false;
  var _openid_tokens;

  bool getSignedIn() {
    var tokens = window.localStorage['openid_client:tokens'];

    if (tokens != null) {
      _openid_tokens = json.decode(tokens);

      if (_openid_tokens != null && _openid_tokens['access_token'] != null) {
        _signedIn = true;
        log('auth token $tokens');
        log('auth tokens $_openid_tokens');
        log('auth scope ${_openid_tokens["scope"]}');
        log('auth openid_client:auth ${window.localStorage['openid_client:auth']}');
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
