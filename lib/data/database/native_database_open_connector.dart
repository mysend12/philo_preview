import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:philo/data/database/database_open_connector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DatabaseOpenConnectorImpl extends DatabaseOpenConnector {

  @override
  QueryExecutor openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'philo.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }

}