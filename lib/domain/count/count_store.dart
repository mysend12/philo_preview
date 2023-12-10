import 'package:philo/common/dependency_injection.dart';
import 'package:philo/data/database/count/repository/count_repository.dart';
import 'package:philo/domain/count/count_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'dto/count_dto.dart';

class CountStore {
  CountStore(this._repository, this._ref);

  final CountRepository _repository;
  final ProviderRef<CountStore> _ref;

  Future<void> increase(CountDto countDto) async {
    CountState countState = _ref.read(countStateProvider);
    countState = countState.copyWith(
        countDto: countDto.copyWith(number: countDto.number + 1));

    await _repository.increase(countDto.id!);
  }

  Future<void> decrease(CountDto countDto) async {
    if (countDto.number == 0) return;

    CountState countState = _ref.watch(countStateProvider);
    countState.copyWith(
        countDto: countDto.copyWith(number: countDto.number - 1));
    await _repository.decrease(countDto.id!);
  }
}
