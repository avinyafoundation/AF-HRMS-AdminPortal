import 'package:flutter/material.dart';

import '../data.dart';

class OrganizationDetailsScreen extends StatelessWidget {
  final Organization? organization;

  const OrganizationDetailsScreen({
    super.key,
    this.organization,
  });

  @override
  Widget build(BuildContext context) {
    if (organization == null) {
      return const Scaffold(
        body: Center(
          child: Text('No Organization found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(organization!.id!.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              organization!.name!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              organization!.description!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              organization!.phone_number1!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              organization!.phone_number2!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
