import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moovup/model/data.dart';
import '../../ui_base_for_testing.dart';
import 'package:moovup/ui/widgets/widget_list.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets("'WidgetList' should render all 'Person's when needed (lazily).",
      (tester) async {
    final json = [
      {
        "_id": "73dba524-2fb9-42e6-ae3b-e11c8205d0af",
        "name": {"last": "Wagner", "first": "Camacho"},
        "email": "camacho.wagner@undefined.com",
        "picture": "http://placehold.it/175x244",
        "location": {"latitude": 22.3417661, "longitude": null}
      },
      {
        "_id": "875e27dc-7836-4208-9f5f-87c31d64ba0e",
        "name": {"last": "Diaz", "first": "Janice"},
        "email": "janice.diaz@undefined.us",
        "picture": "http://placehold.it/56x210",
        "location": {"latitude": 22.3557118, "longitude": null}
      },
      {
        "_id": "4488f53c-0d67-4f11-9bff-1b970df2a2e3",
        "name": {"last": "Harrington", "first": "Hilda"},
        "email": "hilda.harrington@undefined.io",
        "picture": "http://placehold.it/180x218",
        "location": {"latitude": 22.3479143, "longitude": 113.698436}
      },
      {
        "_id": "5c4a7d14-5275-4ea7-89d4-bc16db929132",
        "name": {"last": "Sargent", "first": "Good"},
        "email": "good.sargent@undefined.biz",
        "picture": "http://placehold.it/110x85",
        "location": {"latitude": 22.3527298, "longitude": 114.014816}
      },
      {
        "_id": "f06fad02-e844-4eb4-9ff0-108b5c547105",
        "name": {"last": "Norris", "first": "Rhea"},
        "email": "rhea.norris@undefined.info",
        "picture": "http://placehold.it/169x241",
        "location": {"latitude": 22.3774878, "longitude": null}
      },
      {
        "_id": "ac0fb0f6-6a6b-4098-9073-6218d17ecbec",
        "name": {"last": "Erickson", "first": "Grimes"},
        "email": "grimes.erickson@undefined.me",
        "picture": "http://placehold.it/157x183",
        "location": {"latitude": 22.3153652, "longitude": 113.783836}
      },
      {
        "_id": "f8f7f1b8-b5e8-45a8-807f-41d76feab624",
        "name": {"last": "Glass", "first": "Boyd"},
        "email": "boyd.glass@undefined.biz",
        "picture": "http://placehold.it/80x89",
        "location": {"latitude": 22.3846446, "longitude": null}
      },
      {
        "_id": "d5bd6fed-7eeb-4326-8edb-9b1ab5bc4a75",
        "name": {"last": "Snyder", "first": "Lenora"},
        "email": "lenora.snyder@undefined.net",
        "picture": "http://placehold.it/187x230",
        "location": {"latitude": 22.3105129, "longitude": 113.90516}
      },
    ];

    final persons = json.map((e) => Person.fromJSON(e)).toList();

    mockNetworkImagesFor(() async {
      await tester.pumpWidget(ScaffoldBase(
          testWidget: WidgetList(
        persons: persons,
      )));

      // check the first person
      expect(find.text(persons.first.name.toString()), findsOneWidget);
      // no email is shown
      expect(find.text(persons.first.email), findsNothing);

      // check the last person
      // drag to make the last person show up
      await tester.dragUntilVisible(find.text(persons.last.name.toString()),
          find.byType(ListView), const Offset(0, -100));
      await tester.pump(const Duration(seconds: 1));

      // check the last person's name
      expect(find.text(persons.last.name.toString()), findsOneWidget);
    });
  });
}
