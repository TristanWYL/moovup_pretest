import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:moovup/model/data.dart';
import 'package:moovup/ui/widgets/map_marker.dart';
import 'package:moovup/ui/widgets/name_card.dart';
import 'package:moovup/ui/widgets/widget_map.dart';

class PersonalMap extends StatelessWidget {
  const PersonalMap({Key? key, required this.profile}) : super(key: key);
  final Person profile;
  @override
  Widget build(BuildContext context) {
    final marker = createMarker(profile);
    final options = MapOptions(
      center: LatLng(profile.location.latitude, profile.location.longitude!),
      zoom: 13.0,
      interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: WidgetMap(options: options, markers: [marker]),
          ),
          NameCard(key: Key(profile.id), profile: profile, bShowEmail: true),
        ],
      ),
    );
  }
}
