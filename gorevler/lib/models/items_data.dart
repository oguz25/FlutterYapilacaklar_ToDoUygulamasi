import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gorevler/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemData with ChangeNotifier {
  final List<Item> _items = [
    //Item(title: 'Peynir Al'),
    //Item(title: 'Çöpü at'),
    //Item(title: 'Faturayı öde'),
  ];
  static SharedPreferences _sharedPref;
  List<String> _itemsAsString = [];
  void toggleStatus(int index) {
    _items[index].toggleStatus();
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  void addItem(String title) {
    _items.add(Item(title: title));
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  ///Shared metotlar
  Future<void> createPrefObject() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  void saveItemsToSharedPref(List<Item> items) {
    //List<Item> --->List<String>
    _itemsAsString.clear();
    for (var item in items) {
      _itemsAsString.add(json.encode(item.toMap()));
    }
    //sharedPref kaydet
    _sharedPref.setStringList('toDoDate', _itemsAsString);
  }

  void loadItemsFromSharedPref() {
    List<String> tempList = _sharedPref.getStringList('toDoData') ?? [];
    _itemsAsString.clear();
    for (var item in tempList) {
      _items.add(Item.fromMap(json.decode(item)));
    }
  }
}
