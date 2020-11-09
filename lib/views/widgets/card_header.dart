import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardHeader extends StatelessWidget {
  final Widget icon;
  final String label;
  final Widget leading;
  final Color color;
  final double height = 48;
  final TextAlign labelAlign;
  final Widget title;

  const CardHeader({
    Key key,
    this.icon,
    this.label,
    this.color,
    this.labelAlign,
    this.leading,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.secondaryVariant),
      child: IconTheme(
        data: Theme.of(context)
            .iconTheme
            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            SizedBox(width: 8),
            if (leading != null) ...[leading, SizedBox(width: 8)],
            if (title != null)
              title
            else
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).primaryTextTheme.headline6.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary),
                  textAlign: labelAlign,
                ),
              ),
            if (icon != null) ...[icon, SizedBox(width: 8)],
          ],
        ),
      ),
    );
  }
}
