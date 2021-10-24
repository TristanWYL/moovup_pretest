import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../ui_base_for_testing.dart';
import 'package:moovup/ui/widgets/map_marker.dart';

void main() {
  testWidgets(
      "The map marker can render a mark with a 'Icons.place' icon, and clicking on the icon will show the name of the relevant person. Clicking on the icon again will make hide the name.",
      (tester) async {
    const name = "xxxx";
    MapMarker marker = const MapMarker(name: name);
    await tester.pumpWidget(ScaffoldBase(testWidget: marker));
    expect(find.byIcon(Icons.place), findsOneWidget);

    // by default the name does not show up
    expect(find.text(name), findsNothing);

    // tap the icon
    await tester.tap(find.byIcon(Icons.place));
    await tester.pumpAndSettle();

    // the name text should appear
    expect(find.text(name), findsOneWidget);
  });
}
