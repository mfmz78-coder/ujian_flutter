import 'package:flutter/material.dart';

import '../models/application.dart';
import 'my_applications_screen.dart';
import 'programme_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  // Shared state:
  // Borang akan menambah permohonan ke senarai ini.
  // Tab "Permohonan Saya" akan membaca senarai yang sama.
  final List<Application> _applications = [];

  void _handleApplicationSubmitted(Application application) {
    setState(() {
      _applications.add(application);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      ProgrammeListScreen(
        onApplicationSubmitted: _handleApplicationSubmitted,
      ),
      MyApplicationsScreen(
        applications: _applications,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('eTT Mobile'),
      ),
      body: pages[_selectedTab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_alt),
            label: 'Tawaran',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            label: 'Permohonan Saya',
          ),
        ],
      ),
    );
  }
}