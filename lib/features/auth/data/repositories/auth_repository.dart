import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:yuktidea_flutter_deveoper_task/features/auth/data/datasources/auth_data_source.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/models/register_model.dart';

class AuthRepository {
  final AuthDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepository({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<String, Map<String, dynamic>>> login(
    Map<String, dynamic> loginModel,
  ) async {
    Logger().d(loginModel);
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.login(loginModel);
        Logger().d(response);
        return Right(response);
      } on ServerException {
        return const Left('something went wrong!');
      } catch (e) {
        Logger().d(e.toString());
        return Left(e.toString());
      }
    }
    return left('No internet Connection');
  }

  Future<Either<String, Map<String, dynamic>>> register(
    RegisterModel registerModel,
  ) async {
    Logger().d(registerModel);
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.register(registerModel);
        Logger().d(response);
        return Right(response);
      } on ServerException {
        return const Left('something went wrong!');
      } catch (e) {
        Logger().d(e.toString());
        return Left(e.toString());
      }
    }
    return left('No internet Connection');
  }
}
