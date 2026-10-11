import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Mocked data for the POC.
  static const _name = "Stella's Sausage Dog";
  static const _totalWalks = 42;
  static const _totalKm = 127.5;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(_name,
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center),
            const Spacer(),
            // Placeholder for the customizable dog avatar.
            const Text('🐕', style: TextStyle(fontSize: 160)),
            const Spacer(),
            const Row(
              children: [
                Expanded(child: _StatCard(label: 'Total walks', value: '$_totalWalks')),
                SizedBox(width: 16),
                Expanded(child: _StatCard(label: 'Total km walked', value: '$_totalKm')),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          children: [
            Text(value, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
