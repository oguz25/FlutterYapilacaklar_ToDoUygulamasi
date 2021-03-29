import 'dart:convert';

main() {
  Item itemObject = Item(title: 'uyu', isDone: true);
  print('itemObject: $itemObject');
  print('itemObject Type: ${itemObject.runtimeType}');

  Map itemAsMap = itemObject.toMap();
  print('itemAsMap: $itemAsMap');
  print('itemAsMap Type: ${itemAsMap.runtimeType}');

  String itemAsJson = json.encode(itemAsMap);
  print('itemAsJson: $itemAsJson');
  print('itemAsJson Type: ${itemAsJson.runtimeType}');
  itemAsMap = json.decode(itemAsJson);
  //itemObject = Item(title: itemAsMap['title'], isDone: itemAsMap['isDone']);
  itemObject = Item.fromMap(itemAsMap);
  print(itemObject);
}

class Item {
  String title;
  bool isDone;
  Item({this.title, this.isDone});
  Item.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        isDone = map['isDone'];
  Map<String, dynamic> toMap() => {'title': title, 'isDone': isDone};
}
