import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/discover/data/repository/futsal_remote_repository.dart';
import 'package:my_arena/features/discover/domain/entity/futsal_entity.dart';

final futsalRepositoryProvider = Provider.autoDispose<IFutsalRepository>(
  (ref) {
    return ref.read(futsalRemoteRepositoryProvider);
  },
);

abstract class IFutsalRepository {
  Future<Either<Failure, List<FutsalEntity>>> getAllFutsals(int page);
}
