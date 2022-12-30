import 'package:flutter/material.dart';

class ExampleWidget extends StatelessWidget {
  final String? text;
  const ExampleWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text ?? 'Hello World'));
  }
}
