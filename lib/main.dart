import 'dart:io';

import 'package:dio/dio.dart';
import 'package:herogame/services/database/couchbase.dart';
import 'package:herogame/services/router/router.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'app.dart';

const APP_DB = "app";
Dio dio = Dio();
CookieJar cookieJar = CookieJar();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dio.interceptors.add(CookieManager(cookieJar));

  // Directory appDocDir = await getApplicationDocumentsDirectory();
  // Cbl.init();
  final app = App(localDB: null);

  final router = AppRouter(app);

  runApp(
    MaterialApp(
      title: 'Dive Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: router.routes,
      onGenerateRoute: router.onGenerateRoute,
    ),
  );
}
