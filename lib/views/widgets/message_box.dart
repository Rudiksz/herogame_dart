import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final Function onTap;
  final String message;
  final String type;

  static const String error = 'error';
  static const String info = 'info';

  const MessageBox({
    Key key,
    this.onTap,
    this.message,
    this.type = MessageBox.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: Card(
        child: ListTile(
          title: Text(message),
          onTap: onTap,
          leading: Icon(
            type == error ? Icons.error : Icons.info,
            color: type == error ? Colors.red : Colors.black,
          ),
          trailing: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
