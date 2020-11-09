import 'package:flutter/material.dart';

class NetworkProgressIndicator extends StatelessWidget {
  final String title;
  const NetworkProgressIndicator({
    Key key,
    this.title = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
