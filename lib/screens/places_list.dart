import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place.dart';
import 'package:great_places/screens/place_detail.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Places"),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                })
          ],
        ),
        body: Consumer<GreatPlaces>(
            child: Center(child: Text("Got no places yet")),
            builder: (ctx, greatPlaces, ch) {
              return greatPlaces.items.length <= 0
                  ? ch
                  : ListView.builder(
                      itemBuilder: (ctx, i) {
                        return ListTile(
                          subtitle: Text(greatPlaces.items[i].location?.address??""),
                          leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.items[i].image)),
                          title: Text(greatPlaces.items[i].title),
                          onTap: () {
                            Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.items[i].id);
                          },
                        );
                      },
                      itemCount: greatPlaces.items.length);
            }));
  }
}
