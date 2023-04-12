import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
