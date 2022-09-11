import 'package:flutter/material.dart';
import 'package:openid_client/openid_client_browser.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

class SignInScreen extends StatefulWidget {
  final ValueChanged<Credentials> onSignIn;

  const SignInScreen({
    required this.onSignIn,
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // final _usernameController = TextEditingController();
  // final _passwordController = TextEditingController();

  // @override
  // Widget build(BuildContext context) => Scaffold(
  //       body: Center(
  //         child: Card(
  //           child: Container(
  //             constraints: BoxConstraints.loose(const Size(600, 600)),
  //             padding: const EdgeInsets.all(8),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text('Sign in', style: Theme.of(context).textTheme.headline4),
  //                 TextField(
  //                   decoration: const InputDecoration(labelText: 'Username'),
  //                   controller: _usernameController,
  //                 ),
  //                 TextField(
  //                   decoration: const InputDecoration(labelText: 'Password'),
  //                   obscureText: true,
  //                   controller: _passwordController,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(16),
  //                   child: TextButton(
  //                     onPressed: () async {
  //                       widget.onSignIn(Credentials(
  //                           _usernameController.value.text,
  //                           _passwordController.value.text));
  //                     },
  //                     child: const Text('Sign in'),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  final String _clientId = '_JoZvBSxTISlYQoZhNogFs8dHXsa';
  //final String _redirectUrl = 'http://localhost:52004/';
  static const String _issuerUrl =
      'https://api.asgardeo.io/t/avinyafoundation/oauth2/token';
  // final String _discoveryUrl =
  //     'https://api.asgardeo.io/t/avinyafoundation/oauth2/token/.well-known/openid-configuration';
  final List<String> _scopes = <String>[
    'openid',
    'profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      fit: BoxFit.contain,
                      width: 30,
                    ),
                    Text("Login with Google"),
                  ],
                ),
                onPressed: () async {
                  await authenticate(Uri.parse(_issuerUrl), _clientId, _scopes);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  authenticate(Uri uri, String clientId, List<String> scopes) async {
    // create the client
    var issuer = await Issuer.discover(uri);
    var client = new Client(issuer, clientId);

    // create an authenticator
    var authenticator = new Authenticator(client, scopes: scopes);

    // starts the authentication
    authenticator.authorize();
  }
}
