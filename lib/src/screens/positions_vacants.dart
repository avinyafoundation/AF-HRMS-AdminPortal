import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets/positions_vacant_list.dart';

class PositionsVacantScreen extends StatefulWidget {
  const PositionsVacantScreen({
    super.key,
  });

  @override
  State<PositionsVacantScreen> createState() => _PositionsVacantScreenState();
}

class _PositionsVacantScreenState extends State<PositionsVacantScreen>
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
    if (newPath.startsWith('/positions_vacants/all')) {
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
          title: const Text('PositionsVacant'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'All PositionsVacants',
                icon: Icon(Icons.list_alt),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            PositionsVacantList(
              positionsVacantList: [],
              onTap: _handlePositionsVacantTapped,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context)
                .push<void>(
                  MaterialPageRoute<void>(
                    builder: (context) => AddPositionsVacantPage(),
                  ),
                )
                .then((value) => setState(() {}));
          },
          child: const Icon(Icons.add),
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);

  void _handlePositionsVacantTapped(PositionsVacant positionsVacant) {
    _routeState.go('/positions_vacant/${positionsVacant.id}');
  }

  void _handleTabIndexChanged() {
    switch (_tabController.index) {
      case 0:
      default:
        _routeState.go('/positions_vacants/all');
        break;
    }
  }
}
