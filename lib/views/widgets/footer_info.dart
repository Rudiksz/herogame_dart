import 'package:flutter/material.dart';

class FooterInfo extends StatelessWidget {
  final String value;
  final List<String> values;
  final IconData iconData;
  final Widget icon;
  final String label;
  final TextStyle labelStyle;
  final Color color;

  final FooterInfoAlignment alignment;
  final Function onTap;

  final double size;

  final double textScaleFactor;

  final double minWidth;

  const FooterInfo(
      {Key key,
      this.value,
      this.iconData,
      this.label,
      this.labelStyle,
      this.onTap,
      this.color,
      this.values,
      this.size = 24,
      this.textScaleFactor,
      this.alignment = FooterInfoAlignment.start,
      this.minWidth = 0,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = this.color ?? Theme.of(context).colorScheme.onSurface;

    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: alignment == FooterInfoAlignment.start
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: alignment == FooterInfoAlignment.start
              ? startAligned(context, color)
              : endAligned(context, color),
        ),
      ),
    );
  }

  startAligned(BuildContext context, Color color) => <Widget>[
        SizedBox(width: 4),
        if (iconData != null) ...[
          Icon(iconData, color: color, size: size),
          SizedBox(width: 8)
        ],
        if (icon != null) ...[icon, SizedBox(width: 8)],
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200, minWidth: minWidth),
          child: Text(
            value ?? "",
            softWrap: true,
            textScaleFactor: textScaleFactor,
            style: labelStyle ??
                Theme.of(context).textTheme.bodyText1.copyWith(color: color),
          ),
        ),
        SizedBox(width: 4),
      ];

  endAligned(BuildContext context, Color color) => <Widget>[
        SizedBox(width: 4),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 140, minWidth: minWidth),
          child: Text(
            value ?? "",
            softWrap: true,
            textScaleFactor: textScaleFactor,
            textAlign: TextAlign.end,
            style: labelStyle ??
                Theme.of(context).textTheme.bodyText1.copyWith(color: color),
          ),
        ),
        if (iconData != null) ...[
          SizedBox(width: 8),
          Icon(iconData, color: color, size: size)
        ],
        if (icon != null) ...[SizedBox(width: 8), icon],
        SizedBox(width: 4),
      ];
}

enum FooterInfoAlignment { start, center, end }
