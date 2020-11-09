import 'dart:io';

import 'package:herogame/app.dart';
import 'package:herogame/views/widgets/notifications.dart';
import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  final App app;

  final Widget body;
  final Widget title;

  final Widget drawer;
  final Widget fab;

  final Function onReload;

  const CommonScaffold(
    this.app, {
    Key key,
    @required this.body,
    this.title,
    this.drawer,
    this.fab,
    this.onReload,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Banner(
      location: BannerLocation.bottomStart,
      message: Platform.operatingSystem,
      child: SafeArea(
        child: NotificationListener<DatabaseOperation>(
          onNotification: (notification) =>
              app.databaseChanged = !app.databaseChanged,
          child: Scaffold(
            appBar: AppBar(
              title: title ?? SizedBox.shrink(),
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: onReload,
                  ),
                )
              ],
            ),
            drawer: drawer,
            floatingActionButton: fab,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.background,
                    Theme.of(context).colorScheme.primary.withOpacity(.2)
                  ],
                ),
              ),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}

class DatabaseChangeIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Fade();
}

class _Fade extends State<DatabaseChangeIcon>
    with SingleTickerProviderStateMixin {
  int blinkCount = 0;
  AnimationController animation;
  Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.8).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        blinkCount += 1;
        if (blinkCount <= 3) animation.forward();
      }
    });
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInFadeOut,
      child: Icon(Icons.save_alt),
    );
  }
}
