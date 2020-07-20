import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/AddPlacePage.dart';
import '../providers/Places.dart';

class PlacesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacePage.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                child: Center(
                  child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, places, ch) => places.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(places.items[i].image),
                          ),
                          title: Text(places.items[i].title),
                          onTap: () {},
                        ),
                      ),
              ),
      ),
    );
  }
}
