import 'package:flutter/material.dart';
import 'package:todo_diversition/constants/colours.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colours.primary,
        strokeWidth: 1.5,
      ),
    );
  }
}
