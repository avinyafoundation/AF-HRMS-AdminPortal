import 'package:flutter/material.dart';

// import '../data.dart';
import '../routing.dart';
import '../screens/teams.dart';

class HRMPeopleScreen extends StatefulWidget {
  const HRMPeopleScreen({
    super.key,
  });

  @override
  State<HRMPeopleScreen> createState() => _HRMPeopleScreenState();
}

class _HRMPeopleScreenState extends State<HRMPeopleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabIndexChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newPath = _routeState.route.pathTemplate;
    if (newPath.startsWith('/hrm_people/teams')) {
      _tabController.index = 0;
    } else if (newPath.startsWith('/hrm_people/recruitments')) {
      _tabController.index = 1;
    } else if (newPath == '/hrm_people/plan') {
      _tabController.index = 2;
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
          title: const Text('HRM People'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Teams',
                icon: Icon(Icons.people),
              ),
              Tab(
                text: 'Recruitments',
                icon: Icon(Icons.people_outlined),
              ),
              Tab(
                text: 'Plans',
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            TeamsScreen(),
            TeamsScreen(),
            TeamsScreen(),
          ],
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);

  // void _handleBookTapped(Book book) {
  //   _routeState.go('/book/${book.id}');
  // }

  void _handleTabIndexChanged() {
    switch (_tabController.index) {
      case 1:
        _routeState.go('/hrm_people/recruitments');
        break;
      case 2:
        _routeState.go('/hrm_people/plan');
        break;
      case 0:
      default:
        _routeState.go('/hrm_people/teams');
        break;
    }
  }
}
