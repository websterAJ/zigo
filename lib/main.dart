import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'providers/app_state.dart';
import 'components/zigo_bottom_nav_bar.dart';
import 'screens/accounts_receivable_screen.dart';
import 'screens/customer_detail_screen.dart';
import 'screens/customer_form_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/product_form_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zigo Enterprise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF002446),
          primary: const Color(0xFF002446),
          secondary: const Color(0xFF1B6D24),
          surface: const Color(0xFFF7F9FF),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _selectedIndex = 1; // Default to Customers

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    Widget body;
    switch (_selectedIndex) {
      case 0:
        body = const AccountsReceivableScreen();
        break;
      case 1:
        body = ListView.builder(
          itemCount: state.customers.length,
          itemBuilder: (context, index) {
            final customer = state.customers[index];
            return ListTile(
              leading: CircleAvatar(child: Text(customer.name[0])),
              title: Text(customer.name),
              subtitle: Text(customer.id),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerDetailScreen(customer: customer))),
            );
          },
        );
        break;
      case 2:
        body = ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            final product = state.products[index];
            return ListTile(
              leading: Image.network(product.imageUrl ?? '', width: 50, height: 50, fit: BoxFit.cover),
              title: Text(product.name),
              subtitle: Text(product.sku),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
            );
          },
        );
        break;
      default:
        body = const Center(child: Text('Reports Placeholder'));
    }

    return Scaffold(
      appBar: _selectedIndex != 0 ? AppBar(
        title: const Text('Zigo Enterprise'),
        actions: [
          if (_selectedIndex == 1) IconButton(icon: const Icon(Icons.person_add), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerFormScreen()))),
          if (_selectedIndex == 2) IconButton(icon: const Icon(Icons.add_box), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductFormScreen()))),
        ],
      ) : null,
      body: body,
      bottomNavigationBar: ZigoBottomNavBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
