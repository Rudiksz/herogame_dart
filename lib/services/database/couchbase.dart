library Couchbase;

import 'package:couchbase_lite_dart/couchbase_lite_dart.dart';
import 'package:flutter/foundation.dart';

class Couchbase {
  String name;

  Database _db;
  Database get db => _db;

  Replicator replicator;
  Replicator docsReplicator;
  String replicatorListenerToken;

  Map<String, LiveQuery> liveQueries = {};
  Map<String, Query> queries = {};

  Couchbase(this.name, {String path, bool open = true}) {
    _db = Database(name, directory: path, doOpen: open);
    // TODO create indexes... eventually
  }

  open({String path}) {}

  close() {
    // TODO is it necessary to dispose of the live queries here?
    if (replicator == null) {
      _db.close();
    } else {
      replicator.addChangeListener(onReplicatorStopped);
      replicator?.stop();
    }
  }

  onReplicatorStopped(change) {
    db?.close();
    // TODO dispose of the C replicator
    replicator = null;
    // TODO dispose of the C database
    _db = null;
  }

  initReplicator(String sessionID, Function(ReplicatorStatus) changeListener) {
    replicator = Replicator(
      _db,
      endpointUrl: "ws://192.168.43.145:4984/divemanager/",
      replicatorType: ReplicatorType.pushAndPull,
      continuous: true,
      sessionId: sessionID,
    );

    if (changeListener != null) {
      replicatorListenerToken = replicator.addChangeListener(changeListener);
    }

    replicator.start();
  }

  Document document(String id) => db.getDocument(id);

  deleteDocument(String id) => db.getDocument(id).delete();

  @deprecated
  saveDocument(String id, Map data) {
    db.saveDocument(Document(id, data: data));
  }

  Future<List> doQuery(
    Query query, {
    String queryName = "query",
    Function(List change) onResultsChanged,
    bool explain = false,
  }) async {
    assert(_db != null, "You can't create a query without a database.");

    // Dispose of any previous live query with the same name
    await disposeQuery(queryName);

    List results = [];
    String listenerToken;
    if (onResultsChanged != null) {
      listenerToken = query.addChangeListener(onResultsChanged);
    }

    liveQueries[queryName] = LiveQuery(
      name: queryName,
      query: query,
      token: listenerToken,
    );

    try {
      if (explain) debugPrint(query.explain());
      results = await query.execute();
    } on CouchbaseLiteException catch (e) {
      // TODO implement error handling
      print("*** Query error: ****");
      print(e);
    }

    return results;
  }

  disposeQuery(String name) {
    if (queries[name] != null) {
      queries.remove(name).dispose();
    }
  }
}

class LiveQuery {
  final String name;
  final Query query;
  final String token;

  LiveQuery({this.name, this.query, this.token});

  dispose() {
    if (query != null && token != null) query.removeChangeListener(token);
  }
}
