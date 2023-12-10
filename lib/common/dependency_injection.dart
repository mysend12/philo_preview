import 'package:drift/backends.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:philo/data/database/count/count_database.dart';
import 'package:philo/data/database/count/repository/count_repository.dart';
import 'package:philo/data/database/database_open_connector_impl.dart'
    if (dart.library.io) 'package:philo/data/database/native_database_open_connector.dart'
    if (dart.library.html) 'package:philo/data/database/web_database_open_connector.dart';
import 'package:philo/domain/count/count_store.dart';

import '../domain/count/count_state.dart';
import '../domain/count/dto/count_dto.dart';

late final Provider<QueryExecutor> queryExecutorProvider;
late final Provider<CountRepository> countRepositoryProvider;
late final Provider<CountState> countStateProvider;
late final Provider<CountStore> countStoreProvider;

dependencyInjection() async {
  QueryExecutor queryExecutor = DatabaseOpenConnectorImpl().openConnection();
  CountDatabase countDatabase = CountDatabase(queryExecutor);
  CountRepository countRepository = CountRepository(countDatabase);

  List<CountEntityData> counts = await countRepository.findAll();
  CountEntityData count =
      counts.isNotEmpty ? counts.first : await countRepository.save(1);
  CountDto countDto = CountDto.fromJson(count.toJson());

  queryExecutorProvider = Provider((ref) => queryExecutor);
  countRepositoryProvider = Provider((ref) => countRepository);
  countStoreProvider = Provider((ref) => CountStore(countRepository, ref));
  countStateProvider =
      Provider((ref) => CountState(countDto: countDto, ref: ref));
}
