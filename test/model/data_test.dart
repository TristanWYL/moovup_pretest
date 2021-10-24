import 'package:flutter_test/flutter_test.dart';
import 'package:moovup/model/data.dart';

void main() {
  group("Data model", () {
    test("The model 'Name' should be able to stringify itself correctly.", () {
      const last = "XXXX";
      const first = "YYYY";
      final name = Name(last: last, first: first);
      expect("$first $last", name.toString());
    });

    test("The model 'Person' should be able to spawn instances from JSON data.",
        () {
      Map<String, dynamic> json = {
        "_id": "8cd345e4-5ebe-435f-8352-a90837981973",
        "name": {"last": "Hart", "first": "Isabelle"},
        "email": "isabelle.hart@undefined.ca",
        "picture": "http://placehold.it/138x110",
        "location": {"latitude": 22.3359512, "longitude": 113.665635}
      };

      final person = Person.fromJSON(json);

      expect(person.id, json['_id']);
      expect(person.name.last, json['name']['last']);
      expect(person.name.last, json['name']['last']);
      expect(person.email, json['email']);
      expect(person.pitctureUrl, json['picture']);
      expect(person.location.latitude, json['location']['latitude']);
      expect(person.location.longitude, json['location']['longitude']);
    });
  });
}
