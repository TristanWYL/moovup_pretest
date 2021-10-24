import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moovup/model/data.dart';
import 'package:moovup/ui/pages/front_page.dart';
import 'package:moovup/ui/pages/personal_map.dart';
import 'package:moovup/ui/widgets/widget_list.dart';
import 'package:moovup/ui/widgets/widget_map.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../ui_base_for_testing.dart';

void main() {
  testWidgets(
      "Will render a CircularProgressIndicator before loading the data.",
      (tester) async {
    final json = [
      {
        "_id": "73dba524-2fb9-42e6-ae3b-e11c8205d0af",
        "name": {"last": "Wagner", "first": "Camacho"},
        "email": "camacho.wagner@undefined.com",
        "picture": "http://placehold.it/175x244",
        "location": {"latitude": 22.3417661, "longitude": 113.783836}
      },
    ];

    final persons = json.map((e) => Person.fromJSON(e)).toList();

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(ScaffoldBase(
          shouldIncludeScaffold: false,
          testWidget: FrontPage(
              personsData: Future.delayed(
                  const Duration(seconds: 10), () => Future.value(persons)))));

      await tester.pump(const Duration(seconds: 5));
      // expect a 'CircularProgressIndicator'
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(const Duration(seconds: 10));
      // after loading the data
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // check the first person
      expect(find.text(persons.first.name.toString()), findsOneWidget);
      // no email is shown
      expect(find.text(persons.first.email), findsNothing);
    });
  });

  testWidgets(
      "Will render 'WidgetList' by default, and will switch to the 'WidgetMap' by tapping the bottom tab.",
      (tester) async {
    final json = [
      {
        "_id": "73dba524-2fb9-42e6-ae3b-e11c8205d0af",
        "name": {"last": "Wagner", "first": "Camacho"},
        "email": "camacho.wagner@undefined.com",
        "picture": "http://placehold.it/175x244",
        "location": {"latitude": 22.3417661, "longitude": 113.783836}
      },
    ];

    final persons = json.map((e) => Person.fromJSON(e)).toList();

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(ScaffoldBase(
          shouldIncludeScaffold: false,
          testWidget: FrontPage(personsData: Future.value(persons))));
      await tester.pump(const Duration(seconds: 10));
      // verify the two bottom tab buttons
      expect(find.byType(BottomNavigationBar), findsNWidgets(1));
      expect(
          (tester.widget(find.byType(BottomNavigationBar).first)
                      as BottomNavigationBar)
                  .items
                  .length ==
              2,
          isTrue);
      expect(
          (tester.widget(find.byType(BottomNavigationBar).first)
                      as BottomNavigationBar)
                  .items[0]
                  .label ==
              "List View",
          isTrue);
      expect(
          (tester.widget(find.byType(BottomNavigationBar).first)
                      as BottomNavigationBar)
                  .items[1]
                  .label ==
              "Map View",
          isTrue);

      // verify current view
      expect(find.byType(WidgetList), findsNWidgets(1));
      expect(find.byType(WidgetMap), findsNWidgets(0));

      // switch the view to map view
      await tester.tap(find.text("Map View"));
      await tester.pump(const Duration(seconds: 5));
      expect(find.byType(WidgetList), findsNWidgets(0));
      expect(find.byType(WidgetMap), findsNWidgets(1));
    });
  });

  testWidgets(
      "When tapping the item of 'WidgetList', it will direct to a new page of 'PersonalMap'.",
      (tester) async {
    final json = [
      {
        "_id": "73dba524-2fb9-42e6-ae3b-e11c8205d0af",
        "name": {"last": "Wagner", "first": "Camacho"},
        "email": "camacho.wagner@undefined.com",
        "picture": "http://placehold.it/175x244",
        "location": {"latitude": 22.3417661, "longitude": 113.783836}
      },
    ];

    final persons = json.map((e) => Person.fromJSON(e)).toList();

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(ScaffoldBase(
          shouldIncludeScaffold: false,
          testWidget: FrontPage(personsData: Future.value(persons))));
      await tester.pump(const Duration(seconds: 5));
      // check the first person
      expect(find.text(persons.first.name.toString()), findsOneWidget);
      // no email is shown
      expect(find.text(persons.first.email), findsNothing);

      // tap the name card
      await tester.tap(find.text(persons.first.name.toString()));
      await tester.pumpAndSettle();

      // now it should be in 'PersonalMap' of the user
      expect(find.byType(PersonalMap), findsOneWidget);
      expect(find.byIcon(Icons.place), findsOneWidget);

      // tap the 'place' icon, the name of the person will show up
      await tester.tap(find.byIcon(Icons.place));
      await tester.pump(const Duration(seconds: 5));
      expect(find.text(persons.first.name.toString()), findsNWidgets(2));

      // tap the 'place' icon again, the name of the person will disappear
      await tester.tap(find.byIcon(Icons.place));
      await tester.pump(const Duration(seconds: 5));
      expect(find.text(persons.first.name.toString()), findsNWidgets(1));
    });
  });

  testWidgets(
      "When tapping the item of 'WidgetList', if the item does not have complete location info, the app will not direct to a new page of 'PersonalMap', instead it will prompt that 'Location information is incomplete'.",
      (tester) async {
    final json = [
      {
        "_id": "ac0fb0f6-6a6b-4098-9073-6218d17ecbec",
        "name": {"last": "Erickson", "first": "Grimes"},
        "email": "grimes.erickson@undefined.me",
        "picture": "http://placehold.it/157x183",
        "location": {"latitude": 22.3153652, "longitude": 113.783836}
      },
      {
        "_id": "73dba524-2fb9-42e6-ae3b-e11c8205d0af",
        "name": {"last": "Wagner", "first": "Camacho"},
        "email": "camacho.wagner@undefined.com",
        "picture": "http://placehold.it/175x244",
        "location": {"latitude": 22.3417661, "longitude": null}
      },
    ];

    final persons = json.map((e) => Person.fromJSON(e)).toList();

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(ScaffoldBase(
          shouldIncludeScaffold: false,
          testWidget: FrontPage(personsData: Future.value(persons))));
      await tester.pump(const Duration(seconds: 5));

      // check the person with incomplete location info
      expect(find.text(persons.last.name.toString()), findsOneWidget);

      // tap the name card
      await tester.tap(find.text(persons.last.name.toString()));
      await tester.pump(const Duration(seconds: 1));

      // now it should still be in 'WidgetList' while not 'PersonalMap'
      expect(find.byType(WidgetList), findsOneWidget);
      expect(find.byType(PersonalMap), findsNothing);

      // and an alert dialog is showing
      expect(find.text("Location information is incomplete!"), findsOneWidget);

      // dismiss the dialog
      await EasyLoading.dismiss(animation: false);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text("Location information is incomplete!"), findsNothing);
    });
  });
}
