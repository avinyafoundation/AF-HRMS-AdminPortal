import 'package:flutter/material.dart';

import '../data.dart';
import '../routing.dart';
import '../widgets/office_list.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({
    super.key,
  });

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen>
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
    if (newPath.startsWith('/offices/all')) {
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
          title: const Text('Office'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'All Offices',
                icon: Icon(Icons.list_alt),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            OfficeList(
              onTap: _handleOfficeTapped,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).push<void>(
              MaterialPageRoute<void>(
                builder: (context) => AddOfficePage(),
              ),
            )
            .then((value) => setState(() {}));
          },
          child: const Icon(Icons.add),
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);

  void _handleOfficeTapped(Office office) {
    _routeState.go('/office/${office.id}');
  }

  void _handleTabIndexChanged() {
    switch (_tabController.index) {
      case 0:
      default:
        _routeState.go('/offices/all');
        break;
    }
  }
}
