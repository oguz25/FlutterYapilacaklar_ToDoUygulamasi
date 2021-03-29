import 'package:flutter/material.dart';
import 'package:gorevler/screens/settings_page.dart';
import 'package:provider/provider.dart';
import '../models/items_data.dart';
import '../widgets/item_card.dart';
import 'item_adder.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  '${Provider.of<ItemData>(context).items.length} Items',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Consumer<ItemData>(
                    builder: (context, itemData, child) => Align(
                          alignment: Alignment.topCenter,
                          child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: itemData.items.length,
                            itemBuilder: (context, index) => ItemCard(
                              toggleStatus: (_) {
                                Provider.of<ItemData>(context, listen: false)
                                    .toggleStatus(index);
                              },
                              title: itemData.items[index].title,
                              isDone: itemData.items[index].isDone,
                              deleteItem: (_) {
                                Provider.of<ItemData>(context, listen: false)
                                    .deleteItem(index);
                              },
                            ),
                          ),
                        )),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: buildFAB(context),
    );
  }

  FloatingActionButton buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          context: context,
          builder: (context) => SingleChildScrollView(child: ItemAdder()),
        );
      },
      child: Icon(Icons.add),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: IconButton(
            icon: Icon(
              Icons.settings,
              size: 25,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
        ),
      ],
      title: Text('Get It Done'),
    );
  }
}
