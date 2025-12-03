import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';

/// Base class for all use cases.
/// Each use case should have a single responsibility and return an Either type
/// containing either a Failure or a Success result.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Used when a use case doesn't need any parameters
class NoParams {
  const NoParams();
}
