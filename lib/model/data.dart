import 'dart:convert';
import 'package:flutter/services.dart';

class Name {
  final String last;
  final String first;
  Name({required this.last, required this.first});

  @override
  String toString(){
    return "$first $last";
  }
}

class Location {
  final double latitude;
  final double? longitude;
  Location({required this.latitude, required this.longitude});
}

class Person {
  final String id;
  final Name name;
  final String email;
  final String pitctureUrl;
  final Location location;
  Person(
      {required this.id,
      required this.name,
      required this.email,
      required this.pitctureUrl,
      required this.location});
  Person.fromJSON(Map<String, dynamic> json)
      : id = json["_id"],
        name = Name(last: json["name"]["last"], first: json["name"]["first"]),
        email = json["email"],
        pitctureUrl = json["picture"],
        location = Location(
            latitude: json["location"]["latitude"],
            longitude: json["location"]["longitude"]);
}

Future<List<Person>> loadJson() async {
  final map = await rootBundle.loadString("assets/data.json").then((value) => jsonDecode(value));
  return map.map<Person>((element) => Person.fromJSON(element)).toList();
}
