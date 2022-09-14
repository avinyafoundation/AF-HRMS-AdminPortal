import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets/job_band_list.dart';

class JobBandScreen extends StatefulWidget {
  const JobBandScreen({
    super.key,
  });

  @override
  State<JobBandScreen> createState() => _JobBandScreenState();
}

class _JobBandScreenState extends State<JobBandScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this)
      ..addListener(_handleTabIndexChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newPath = _routeState.route.pathTemplate;
    if (newPath.startsWith('/job_bands/all')) {
      _tabController.index = 0;
    } 
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('JobBand'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'All JobBands',
                icon: Icon(Icons.list_alt),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            JobBandList(
              onTap: _handleJobBandTapped,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (context) => AddJobBandPage(),
              ),
            )
            .then((value) => setState(() {}));
          },
          child: const Icon(Icons.add),
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);

  void _handleJobBandTapped(JobBand jobBand) {
    _routeState.go('/job_band/${jobBand.id}');
  }

  void _handleTabIndexChanged() {
    switch (_tabController.index) {
      case 0:
      default:
        _routeState.go('/job_bands/all');
        break;
    }
  }
}
