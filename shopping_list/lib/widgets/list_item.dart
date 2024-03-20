import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.groceryItem});

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                color: groceryItem.category.color,
              ), // Category Color
              const SizedBox(width: 25),
              Text(groceryItem.name),
            ],
          ),
          Text(groceryItem.quantity.toString()),
        ],
      ),
    );
  }
}
