import 'package:flutter/material.dart';

import '../data.dart';

class BranchDetailsScreen extends StatelessWidget {
  final Branch? branch;

  const BranchDetailsScreen({
    super.key,
    this.branch,
  });

  @override
  Widget build(BuildContext context) {
    if (branch == null) {
      return const Scaffold(
        body: Center(
          child: Text('No Branch found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(branch!.id!.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              branch!.organization_id!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              branch!.name!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              branch!.description!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              branch!.phone_number1!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              branch!.phone_number2!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
