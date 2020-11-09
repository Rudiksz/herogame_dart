import 'package:flutter/material.dart';
import 'package:herogame/app.dart';
import 'package:herogame/models/character.dart';
import 'package:herogame/views/widgets/ticker_provider.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  final App app;

  final bool selected;
  final Function(Character) onSelected;

  const CharacterTile(
    this.app,
    this.character, {
    Key key,
    this.selected = false,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedPhysicalModel(
        elevation: selected ? 8 : 1,
        color: Theme.of(context).colorScheme.surface,
        duration: Duration(milliseconds: 200),
        shadowColor: selected ? Theme.of(context).primaryColor : Colors.grey,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(selected ? 0 : 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              character?.name ?? "",
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 100),
            vsync: TickerProviderImpl(),
            child: SizedBox(
              width: selected ? 300 : 150,
              height: 300,
              child: app.backendType == 'remote'
                  ? Image.network(app.backendUrl + 'assets/${character.id}.jpg')
                  : Image.asset('assets/${character.id}.jpg'),
            ),
          )
        ],
      ),
      onTap: () => onSelected != null ? onSelected(character) : null,
    );
  }
}
