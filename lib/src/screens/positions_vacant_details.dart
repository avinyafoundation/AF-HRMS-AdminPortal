import 'package:flutter/material.dart';

import '../data.dart';

class PositionsVacantDetailsScreen extends StatelessWidget {
  final PositionsVacant? positionsVacant;

  const PositionsVacantDetailsScreen({
    super.key,
    this.positionsVacant,
  });

  @override
  Widget build(BuildContext context) {
    if (positionsVacant == null) {
      return const Scaffold(
        body: Center(
          child: Text('No PositionsVacant found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(positionsVacant!.id!.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              positionsVacant!.office_id!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              positionsVacant!.job_id!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              positionsVacant!.amount!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              positionsVacant!.start_date!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              positionsVacant!.end_date!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              positionsVacant!.last_updated!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              positionsVacant!.notes!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
