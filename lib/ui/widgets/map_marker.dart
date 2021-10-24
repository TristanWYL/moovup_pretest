import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moovup/model/data.dart';

class MapMarker extends StatefulWidget {
  const MapMarker({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  _MapMarkerState createState() => _MapMarkerState();
}

class _MapMarkerState extends State<MapMarker> {
  bool showName = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showName)
          Container(
            padding: const EdgeInsets.all(5),
            child: Text(widget.name),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        IconButton(
          onPressed: () {
            setState(() {
              showName = !showName;
            });
          },
          icon: const Icon(
            Icons.place,
            color: Colors.red,
            size: 30,
          ),
        )
      ],
    );
  }
}

Marker createMarker(Person profile) => Marker(
    width: 100,
    height: 100,
    anchorPos: AnchorPos.align(AnchorAlign.top),
    point: LatLng(profile.location.latitude, profile.location.longitude!),
    builder: (context) {
      return MapMarker(name: profile.name.toString());
    });
