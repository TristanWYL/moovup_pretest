import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';

class WidgetMap extends StatefulWidget {
  const WidgetMap({Key? key, required this.options, required this.markers})
      : super(key: key);
  // Should have at least two arguments
  // 1. configuration
  // 2. list of markers

  final MapOptions options;
  final List<Marker> markers;

  @override
  _WidgetMapState createState() => _WidgetMapState();
}

class _WidgetMapState extends State<WidgetMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: widget.options,
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: widget.markers
        )
      ],
    );
  }
}
