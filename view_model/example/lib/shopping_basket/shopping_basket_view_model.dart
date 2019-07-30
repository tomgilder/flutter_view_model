import 'package:flutter/foundation.dart';
import 'package:view_model/view_model.dart';

class Item {
  final String title;

  Item({@required this.title});
}

class ShoppingBasketViewModel extends ViewModel {
  final List<Item> items = [];

  void addItem() {
    setState(() {
      items.add(Item(title: "new thing"));
    });
  }
}