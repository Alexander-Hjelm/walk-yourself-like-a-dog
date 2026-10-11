import 'package:flutter/material.dart';

import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';

void main() => runApp(const DogWalkApp());

class DogWalkApp extends StatelessWidget {
  const DogWalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walk Yourself Like a Dog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _screens = [MapScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps the map (and its tracking) alive across tabs.
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Text('🗺️', style: TextStyle(fontSize: 24)),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Text('🐶', style: TextStyle(fontSize: 24)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
