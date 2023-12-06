import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../dto/count_dto.dart';

@freezed
class CountState {
  CountState({required this.countDto, required ref}) : _ref = ref;
  late final ProviderRef<CountState> _ref;
  final CountDto countDto;

  CountState copyWith({CountDto? countDto}) {
    CountState newState = CountState(countDto: countDto ?? this.countDto, ref: _ref);
    _ref.state = newState;
    return newState;
  }
}
