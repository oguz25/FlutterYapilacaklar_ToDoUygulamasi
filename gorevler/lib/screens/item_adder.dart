import 'package:flutter/material.dart';
import 'package:gorevler/models/items_data.dart';
import 'package:provider/provider.dart';

class ItemAdder extends StatelessWidget {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.50,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: textController,
              onChanged: (input) {
                print(textController.text);
              },
              style: TextStyle(color: Colors.black, fontSize: 20),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add Item',
                hintText: '...',
              ),
              autofocus: true,
            ),
            FlatButton(
              onPressed: () {
                Provider.of<ItemData>(context, listen: false)
                    .addItem(textController.text);
                Navigator.pop(context);
              },
              color: Theme.of(context).accentColor,
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
