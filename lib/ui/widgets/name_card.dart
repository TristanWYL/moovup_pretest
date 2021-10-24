import 'package:flutter/material.dart';
import 'package:moovup/model/data.dart';

class NameCard extends StatelessWidget {
  const NameCard({required Key key, required this.profile, required this.bShowEmail}) : super(key: key);
  final Person profile;
  final bool bShowEmail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(profile.pitctureUrl),
              radius: 20,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(profile.name.toString()),
              if(bShowEmail) Text(profile.email),
            ],
          )
        ],
      ),
    );
  }
}