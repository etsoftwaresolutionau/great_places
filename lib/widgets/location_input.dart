import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helper/location_helper.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function setLatLng;
  LocationInput(this.setLatLng);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final previewMapUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);
    widget.setLatLng(locData.latitude, locData.longitude);
    setState(() {
      _previewImageUrl = previewMapUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) {
          return MapScreen(
            isSelecting: true,
          );
        },
      ),
    );

    if (selectedLocation == null) {
      return;
    }

    widget.setLatLng(selectedLocation.latitude, selectedLocation.longitude);

    final previewMapUrl = LocationHelper.generateLocationPreviewImage(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude);
    widget.setLatLng(selectedLocation.latitude, selectedLocation.longitude);
    setState(() {
      _previewImageUrl = previewMapUrl;
    });
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            decoration:
                BoxDecoration(border: Border.all(width: 2, color: Colors.grey)),
            child: _previewImageUrl == null
                ? Center(
                    child: Text(
                      "No location chosen",
                      textAlign: TextAlign.center,
                    ),
                  )
                : Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: Icon(Icons.location_on),
                textColor: Theme.of(context).primaryColor,
                label: Text("Current Location")),
            FlatButton.icon(
                onPressed: _selectOnMap,
                icon: Icon(Icons.map),
                textColor: Theme.of(context).primaryColor,
                label: Text("Select On Map")),
            // FlatButton.icon(
            //     onPressed: () {},
            //     icon: Icon(Icons.location_on),
            //     textColor: Theme.of(context).primaryColor,
            //     label: Text("Current Location")),
          ],
        )
      ],
    );
  }
}
