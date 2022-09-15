import 'package:flutter/material.dart';

import '../data.dart';

class OfficeDetailsScreen extends StatelessWidget {
  final Office? office;

  const OfficeDetailsScreen({
    super.key,
    this.office,
  });

  @override
  Widget build(BuildContext context) {
    if (office == null) {
      return const Scaffold(
        body: Center(
          child: Text('No Office found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(office!.id!.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              office!.branch_id!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              office!.name!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              office!.description!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              office!.phone_number1!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              office!.phone_number2!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
