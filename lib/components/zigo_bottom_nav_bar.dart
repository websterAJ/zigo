import 'package:flutter/material.dart';

class ZigoBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const ZigoBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Sales'),
        NavigationDestination(icon: Icon(Icons.group), label: 'Customers'),
        NavigationDestination(icon: Icon(Icons.inventory_2), label: 'Inventory'),
        NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Reports'),
      ],
    );
  }
}
