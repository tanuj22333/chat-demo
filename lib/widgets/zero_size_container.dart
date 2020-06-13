import 'package:flutter/material.dart';

class ZeroSizeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      width: 0,
    );
  }
}
