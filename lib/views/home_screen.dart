import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:herogame/app.dart';
import 'package:herogame/services/router/router.dart';
import 'package:herogame/views/widgets/card_header.dart';
import 'package:herogame/views/widgets/common_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeScreen extends StatelessWidget {
  final App app;

  const HomeScreen({Key key, this.app}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      app,
      title: Text("Hero Game"),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                CardHeader(
                  labelAlign: TextAlign.center,
                  label: "Select game engine.",
                  leading: Icon(Icons.settings),
                ),
                SizedBox(height: 8),
                Stack(
                  alignment: Alignment(0, 1),
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxWidth: 400, minHeight: 50),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.80),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          buildTab(tab: 'local'),
                          buildTab(tab: 'remote'),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 400, minHeight: 50),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.80),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Observer(
                    builder: (_) =>
                        app.backendType == 'local' ? localBE() : remoteBE(),
                  ),
                ),
                SizedBox(height: 8),
                Observer(builder: (_) {
                  bool disabled = app.backendType == 'remote' &&
                      Platform.isAndroid &&
                      !app.backendUrl.contains('https');
                  return FloatingActionButton.extended(
                    backgroundColor: disabled ? Colors.grey : null,
                    elevation: 20,
                    onPressed: () => disabled
                        ? null
                        : Navigator.pushNamed(context, Routes.character),
                    label: Text('Start your adventure'),
                  );
                }),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTab({String tab = 'local'}) {
    return Expanded(
      child: Observer(
        builder: (context) => Stack(
          alignment: Alignment(0, 1),
          children: <Widget>[
            Container(
              height: 4,
              width: 30,
              margin: EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                color: app.backendType == tab
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            FlatButton(
              onPressed: () => app.backendType = tab,
              child: Text(tab == 'local' ? 'Local' : 'Remote'),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  localBE() {
    return Row(
      children: [
        Flexible(
          child: Text(
            '''* This will use an internal implementation of the game engine.
* Character generation, game and battle mecanics are all run on the device. No internet is required to play.''',
            softWrap: true,
          ),
        ),
      ],
    );
  }

  remoteBE() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '''* This will use a remote implementation of the game engine.
* Game configuration, character generation, game and battle mecanics are all handled by the remote backend.''',
                softWrap: true,
              ),
            ),
          ],
        ),
        Observer(builder: (_) {
          if (Platform.isAndroid && !app.backendUrl.contains('https'))
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '''* Note: Due to Android policies, network requests can be done only on secure connections with properly signed certificates (no self-signed dev certs).''',
                      softWrap: true,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
              ],
            );
          else
            return SizedBox.shrink();
        }),
        SizedBox(height: 8),
        TextFormField(
          initialValue: app.backendUrl,
          onChanged: (v) => app.backendUrl = v,
          style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.white,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.navigate_next),
            border: OutlineInputBorder(),
            hintText: 'Set the backend URL',
            fillColor: Colors.blue[100],
            filled: true,
          ),
        )
      ],
    );
  }
}
