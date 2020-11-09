import 'package:flutter/material.dart';

class FormChangedNotification extends Notification {
  final bool value;
  FormChangedNotification(this.value);
}

class AccountChangedNotification extends Notification {
  AccountChangedEvent event = AccountChangedEvent.saved;
  AccountChangedNotification({this.event});
}

enum AccountChangedEvent { added, saved, deleted }

class DatabaseOperation extends Notification {
  DatabaseOperationType type = DatabaseOperationType.update;
  String id = '';
  DatabaseOperation({this.type, this.id});
}

enum DatabaseOperationType { update, delete }
