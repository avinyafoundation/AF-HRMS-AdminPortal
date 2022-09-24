import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

import '../routing.dart';
import '../auth.dart';
import 'scaffold_body.dart';

class SMSScaffold extends StatelessWidget {
  static const pageNames = [
    '/hrm_people/teams',
    '/interviews',
    '/books/popular',
    '/authors',
    // '/address_types/popular',
    // '/organizations/popular',
    // '/branches/popular',
    // '/offices/popular',
    // '/job_bands/popular',
  ];

  const SMSScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        extendBody: true,
        // extendBodyBehindAppBar: true,
        bottomNavigationOverflow: 10,
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
          routeState.go(pageNames[idx]);
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'HRM People',
            icon: Icons.group,
          ),
          AdaptiveScaffoldDestination(
            title: 'Job Interviews',
            icon: Icons.assignment_ind,
          ),
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
          // AdaptiveScaffoldDestination(
          //   title: 'Address Types',
          //   icon: Icons.location_on,
          // ),
          // AdaptiveScaffoldDestination(
          //   title: 'Organizations',
          //   icon: Icons.business,
          // ),
          // AdaptiveScaffoldDestination(
          //   title: 'Branches',
          //   icon: Icons.account_tree_outlined,
          // ),
          // AdaptiveScaffoldDestination(
          //   title: 'Offices',
          //   icon: Icons.account_tree,
          // ),
          // AdaptiveScaffoldDestination(
          //   title: 'Job Bands',
          //   icon: Icons.groups,
          // ),
        ],
      ),
      persistentFooterButtons: [
        new OutlinedButton(
            child: Text('About'),
            onPressed: () {
              showAboutDialog(
                  context: context,
                  applicationName: 'AF HRMS Admin Portal',
                  applicationVersion: '0.1.0');
            }),
        new Text("© 2022, Avinya Foundation."),
      ],
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    int index = pageNames.indexOf(pathTemplate);
    if (index >= 0)
      return index;
    else
      return 0;
  }
}
