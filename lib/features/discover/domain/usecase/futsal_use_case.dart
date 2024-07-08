import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/discover/domain/entity/futsal_entity.dart';
import 'package:my_arena/features/discover/domain/repository/futsal_repository.dart';

final futsalUseCaseProvider = Provider.autoDispose<FutsalUseCase>(
    (ref) => FutsalUseCase(repository: ref.read(futsalRepositoryProvider)));

class FutsalUseCase {
  final IFutsalRepository repository;

  FutsalUseCase({required this.repository});

  Future<Either<Failure, List<FutsalEntity>>> getAllFutsals(int page) async {
    return await repository.getAllFutsals(page);
  }
}
