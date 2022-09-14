import 'package:flutter/material.dart';

import '../data.dart';

class JobBandDetailsScreen extends StatelessWidget {
  final JobBand? jobBand;

  const JobBandDetailsScreen({
    super.key,
    this.jobBand,
  });

  @override
  Widget build(BuildContext context) {
    if (jobBand == null) {
      return const Scaffold(
        body: Center(
          child: Text('No JobBand found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(jobBand!.id!.toString()),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              jobBand!.name!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              jobBand!.description!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              jobBand!.level!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              jobBand!.min_salary!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              jobBand!.max_salary!.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
