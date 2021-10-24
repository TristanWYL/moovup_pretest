import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";
import 'package:moovup/model/data.dart';
import 'package:moovup/ui/widgets/map_marker.dart';
import 'package:moovup/ui/widgets/widget_list.dart';
import 'package:moovup/ui/widgets/widget_map.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key, required this.personsData}) : super(key: key);
  final Future<List<Person>> personsData;

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  int _curTabIndex = 0;
  final List<Widget> _pages = [Container(), Container()];

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.personsData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final _data = snapshot.data as List<Person>;
          getReadyTwoPages(_data);
          return Scaffold(
            body: _pages[_curTabIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex: _curTabIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: "List View"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.map), label: "Map View"),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          );
        }
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _curTabIndex = index;
    });
  }

  void getReadyTwoPages(List<Person> data) {
    _pages[0] = WidgetList(persons: data);
    final markers = data
        .where((element) => element.location.longitude != null)
        .map((p) => createMarker(p))
        .toList();
    final options = MapOptions(
      center: markers.isNotEmpty?LatLng(markers[0].point.latitude, markers[0].point.longitude):null,
      zoom: 13.0,
      interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
    );
    _pages[1] = WidgetMap(options: options, markers: markers);
  }
}
