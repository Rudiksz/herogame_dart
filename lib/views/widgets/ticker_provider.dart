import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TickerProviderImpl extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
