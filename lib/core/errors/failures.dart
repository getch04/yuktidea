import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  final List properties;
  const Failure({this.properties = const <dynamic>[]});
}

// General failures
class ServerFailure extends Failure {
  final String? msg;

  ServerFailure({this.msg});
  @override
  List<Object?> get props => [msg];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
