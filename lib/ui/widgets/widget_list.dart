import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:moovup/model/data.dart';
import 'package:moovup/ui/pages/personal_map.dart';
import 'package:moovup/ui/widgets/name_card.dart';

class WidgetList extends StatelessWidget {
  const WidgetList({Key? key, required this.persons}) : super(key: key);
  final List<Person> persons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: persons.length,
        separatorBuilder: (ctx, index) => const Divider(
              color: Colors.grey,
              indent: 20,
              endIndent: 20,
            ),
        itemBuilder: (context, index) {
          final _p = persons[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: GestureDetector(
                onTap: () {
                  if (_p.location.longitude == null) {
                    EasyLoading.showInfo(
                      "Location information is incomplete!",
                      duration: const Duration(seconds: 2),
                      maskType: EasyLoadingMaskType.black,
                      dismissOnTap: true,
                    );
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => PersonalMap(profile: _p)));
                  }
                },
                child:
                    NameCard(key: Key(_p.id), profile: _p, bShowEmail: false)),
          );
        });
  }
}
