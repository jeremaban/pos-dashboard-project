import 'package:flutter/material.dart';
import '../sales/sales_summary.dart';
import '../items/items_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _appBarTitle = 'Sales';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _appBarTitle = 'Sales';
      } else if (_selectedIndex == 1) {
        _appBarTitle = 'Items List';
      } else {
        _appBarTitle = 'Settings';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (_selectedIndex == 0) {
      bodyContent = const SalesSummary();
    } else if (_selectedIndex == 1) {
      bodyContent = const ItemsList();
    } else {
      bodyContent = const Center(child: Text('Settings'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        backgroundColor: Colors.blueAccent,
      ),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Sales'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Items'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}