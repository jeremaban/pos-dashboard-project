import 'package:flutter/material.dart';
import '../sales/sales_summary.dart';
import '../items/items_list.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final List<Map<String, String>> _itemsListOptions = [
    {'title': 'Inventory', 'value': 'inventory'},
    {'title': 'Critical Level', 'value': 'critical_level'},
    {'title': 'Out of Stock', 'value': 'out_of_stock'},
  ]; //popup options for items

  String _currentListOption = 'Inventory'; //track current list selection

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

  void _showItemsListOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Option'),
          content: Container(
            width: double.minPositive,
            child: ListView(
              shrinkWrap: true,
              children: _itemsListOptions.map((option) {
                return ListTile(
                  title: Text(option['title']!),
                  onTap: () {
                    setState(() {
                      _currentListOption = option['title']!;
                      _appBarTitle = 'Items List';
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (_selectedIndex == 0) {
      bodyContent = const SalesSummary();
    } else if (_selectedIndex == 1) {
      bodyContent = ItemsList(
        listType: _currentListOption.toLowerCase().replaceAll(' ', '_')
      );
    } else {
      bodyContent = const Center(child: Text('Settings'));
    }

    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 1 ? Center(
          child: GestureDetector(
            onTap: () {
              _showItemsListOptions(context);
            },
            child: Row(mainAxisSize: MainAxisSize.min,
            children: [
              Text(_currentListOption),
              Icon(Icons.arrow_drop_down)
            ],)
          )
        ) : Center(child: Text(_appBarTitle)),
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