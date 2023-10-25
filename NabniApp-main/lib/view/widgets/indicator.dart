import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 22.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive
            ? Color.fromARGB(255, 139, 124, 97)
            : Color.fromRGBO(222, 218, 218, 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
