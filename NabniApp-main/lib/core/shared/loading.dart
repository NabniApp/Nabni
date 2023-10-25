import 'package:flutter/material.dart';

class LoadingCircular extends StatelessWidget {
  const LoadingCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: Color(0xff8B7C61)),
    );
  }
}
