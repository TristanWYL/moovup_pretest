import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moovup/model/data.dart';
import 'package:moovup/ui/pages/personal_map.dart';
import 'package:moovup/ui/widgets/name_card.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../ui_base_for_testing.dart';

void main(){
  testWidgets("The personal page should show 'Icons.place', and a 'NameCard' including relevant email.",
      (tester) async {
    final json = 
      {
        "_id": "73dba524-2fb9-42e6-ae3b-e11c8205d0af",
        "name": {"last": "Wagner", "first": "Camacho"},
        "email": "camacho.wagner@undefined.com",
        "picture": "http://placehold.it/175x244",
        "location": {"latitude": 22.3417661, "longitude": 113.783836}
      };

    final person = Person.fromJSON(json);

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(ScaffoldBase(
        shouldIncludeScaffold: false,
          testWidget: PersonalMap(
        profile: person,
      )));

      // tap the 'place' icon, the name of the person will show up
      await tester.tap(find.byIcon(Icons.place));
      await tester.pump(const Duration(seconds: 5));
      // now there should be two names
      expect(find.text(person.name.toString()), findsNWidgets(2));

      // email is shown
      expect(find.text(person.email), findsOneWidget);
    });
  });

  testWidgets("The personal page should show the 'NameCard' at its bottom.",
      (tester) async {
    final json = 
      {
        "_id": "73dba524-2fb9-42e6-ae3b-e11c8205d0af",
        "name": {"last": "Wagner", "first": "Camacho"},
        "email": "camacho.wagner@undefined.com",
        "picture": "http://placehold.it/175x244",
        "location": {"latitude": 22.3417661, "longitude": 113.783836}
      };

    final person = Person.fromJSON(json);

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(ScaffoldBase(
        shouldIncludeScaffold: false,
          testWidget: PersonalMap(
        profile: person,
      )));

      // the NameCard should be in the bottom of the screen
      Rect screenRect = tester.getRect(find.byType(Scaffold));
      Rect nameCardRect = tester.getRect(find.byType(NameCard));
      expect(screenRect.bottom >= nameCardRect.bottom, isTrue);
      expect(screenRect.top < nameCardRect.top, isTrue);
      expect(screenRect.bottom - 100 < nameCardRect.top, isTrue);
    });
  });
}