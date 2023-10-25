import 'package:flutter/material.dart';

class LineDevidor extends StatelessWidget {
  const LineDevidor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(55, 0, 0, 0),
      ),
    );
  }
}
