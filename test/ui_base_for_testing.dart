import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ScaffoldBase extends StatelessWidget {
  const ScaffoldBase({required this.testWidget, Key? key, this.shouldIncludeScaffold = true}) : super(key: key);
  final Widget testWidget;
  final bool shouldIncludeScaffold;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Base Scaffold for testing",
      builder: EasyLoading.init(),
      home: shouldIncludeScaffold?Scaffold(
        body: Center(
          child: testWidget,
        ),
      ): testWidget,
    );
  }
}
