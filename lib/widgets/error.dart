import 'package:flutter/material.dart';

class ErrorOccuredWidget extends StatelessWidget {
  const ErrorOccuredWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Something went wrong.\n\n Please try again later",
        style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
      ),
    );
  }
}
