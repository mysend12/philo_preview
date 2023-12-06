import 'package:drift/drift.dart';
import 'package:drift/web.dart';
import 'package:philo/data/database/database_open_connector.dart';

class DatabaseOpenConnectorImpl extends DatabaseOpenConnector {

  @override
  QueryExecutor openConnection() {
    return WebDatabase("philo");
  }
}
