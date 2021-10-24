import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moovup/model/data.dart';
import '../../ui_base_for_testing.dart';
import 'package:moovup/ui/widgets/name_card.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets(
      "'NameCard' should be able to render the name.",
      (WidgetTester tester) async {
    Map<String, dynamic> json = {
      "_id": "8cd345e4-5ebe-435f-8352-a90837981973",
      "name": {"last": "Hart", "first": "Isabelle"},
      "email": "isabelle.hart@undefined.ca",
      "picture": "http://placehold.it/138x110",
      "location": {"latitude": 22.3359512, "longitude": 113.665635}
    };
    final person = Person.fromJSON(json);
    final NameCard nameCard =
        NameCard(key: Key(person.id), profile: person, bShowEmail: false);

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(ScaffoldBase(testWidget: nameCard));
      expect(find.text(person.name.toString()), findsOneWidget);
      expect(find.text(person.email), findsNothing);
    });
  });

  testWidgets(
      "'NameCard' should be able to render the name, and the email.",
      (WidgetTester tester) async {
    Map<String, dynamic> json = {
      "_id": "8cd345e4-5ebe-435f-8352-a90837981973",
      "name": {"last": "Hart", "first": "Isabelle"},
      "email": "isabelle.hart@undefined.ca",
      "picture": "http://placehold.it/138x110",
      "location": {"latitude": 22.3359512, "longitude": 113.665635}
    };
    final person = Person.fromJSON(json);
    final nameCardWithEmail =
          NameCard(key: Key(person.id), profile: person, bShowEmail: true);
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(ScaffoldBase(testWidget: nameCardWithEmail));
      expect(find.text(person.name.toString()), findsOneWidget);
      expect(find.text(person.email), findsOneWidget);
    });

    
  });
}
