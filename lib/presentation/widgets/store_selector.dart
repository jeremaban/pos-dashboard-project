import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreSelector extends StatelessWidget {
  final String currentStore;
  final List<String> stores;
  final Function(String) onStoreChanged;

  const StoreSelector({
    Key? key,
    required this.currentStore,
    required this.stores,
    required this.onStoreChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 40),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.store, size: 20),
              const SizedBox(width: 8),
              Text(currentStore, style: Theme.of(context).textTheme.bodyMedium),
              const Icon(Icons.arrow_drop_down, size: 20),
            ],
          ),
        ),
        itemBuilder:
            (context) =>
                stores
                    .map(
                      (store) => PopupMenuItem<String>(
                        value: store,
                        child: Text(store),
                      ),
                    )
                    .toList(),
        onSelected: onStoreChanged,
      ),
    );
  }
}
