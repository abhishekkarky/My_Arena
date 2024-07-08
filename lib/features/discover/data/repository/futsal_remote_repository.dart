import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_arena/core/failure/failure.dart';
import 'package:my_arena/features/discover/data/data_source/futsal_remote_data_source.dart';
import 'package:my_arena/features/discover/domain/entity/futsal_entity.dart';
import 'package:my_arena/features/discover/domain/repository/futsal_repository.dart';

final futsalRemoteRepositoryProvider =
    Provider.autoDispose<FutsalRemoteRepoImpl>(
  (ref) => FutsalRemoteRepoImpl(
    futsalRemoteDataSource: ref.read(futsalRemoteDataSourceProvider),
  ),
);

class FutsalRemoteRepoImpl implements IFutsalRepository {
  final FutsalRemoteDataSource futsalRemoteDataSource;

  FutsalRemoteRepoImpl({required this.futsalRemoteDataSource});

  @override
  Future<Either<Failure, List<FutsalEntity>>> getAllFutsals(int page) {
    return futsalRemoteDataSource.getAllFutsals(page);
  }

}
