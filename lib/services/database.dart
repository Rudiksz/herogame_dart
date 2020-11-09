abstract class AppDB {
  final String type = "abstract";
  String name;

  open({String path}) {}
  close() {}

  disposeQuery(String name) {}

  initReplicator(String sessionID, Function(dynamic) changeListener);

  saveDocument(String id, Map<dynamic, dynamic> data);
  deleteDocument(String id);
  document(String id);
}
