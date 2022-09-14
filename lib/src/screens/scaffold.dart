import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

import '../routing.dart';
import '../auth.dart';
import 'scaffold_body.dart';

class SMSScaffold extends StatelessWidget {
  const SMSScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        appBar: AppBar(
          title: const Text('Avinya Foundation - HRMS - Admin Portal'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                SMSAuthScope.of(context).signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User Signed Out')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.info),
              tooltip: 'Help',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Help'),
                      ),
                      body: const Center(
                        child: Text(
                          'This is the help page',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ],
        ),
        body: const SMSScaffoldBody(),
        onDestinationSelected: (idx) {
          if (idx == 0) routeState.go('/books/popular');
          if (idx == 1) routeState.go('/authors');
          // if (idx == 2) routeState.go('/settings');
          // if (idx == 3) routeState.go('/employees/popular');
          if (idx == 2) routeState.go('/address_types/popular');
          if (idx == 3) routeState.go('/job_bands/popular');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Books',
            icon: Icons.book,
          ),
          AdaptiveScaffoldDestination(
            title: 'Authors',
            icon: Icons.person,
          ),
          // AdaptiveScaffoldDestination(
          //   title: 'Settings',
          //   icon: Icons.settings,
          // ),
          // AdaptiveScaffoldDestination(
          //   title: 'Employees',
          //   icon: Icons.people,
          // ),
          AdaptiveScaffoldDestination(
            title: 'Address Types',
            icon: Icons.location_on,
          ),
          AdaptiveScaffoldDestination(
            title: 'Job Bands',
            icon: Icons.groups,
          ),
        ],
      ),
      persistentFooterButtons: [
        new OutlinedButton(
            child: Text('About'),
            onPressed: () {
              showAboutDialog(
                  context: context, applicationName: 'AF HRMS Admin Portal');
            }),
        new Text("© 2022, Avinya Foundation."),
      ],
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate.startsWith('/books')) return 0;
    if (pathTemplate == '/authors') return 1;
    // if (pathTemplate == '/settings') return 2;
    // if (pathTemplate == '/employees') return 3;
    if (pathTemplate == '/address_types') return 2;
    if (pathTemplate == '/job_bands') return 3;
    return 0;
  }
}
