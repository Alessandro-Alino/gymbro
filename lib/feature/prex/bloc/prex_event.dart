part of 'prex_bloc.dart';

sealed class PrexEvent extends Equatable {}

class CreatePrexEvent extends PrexEvent {
  CreatePrexEvent({required this.prex});

  final PrexModel prex;

  @override
  List<Object?> get props => [prex];
}

class ReadPrexEvent extends PrexEvent {
  ReadPrexEvent({required this.programId});

  final int programId;

  @override
  List<Object?> get props => [programId];
}

///
//UPDATE
///
class DeletePrexEvent extends PrexEvent {
  DeletePrexEvent({required this.prex});

  final PrexModel prex;

  @override
  List<Object?> get props => [prex];
}

class TogglePrexEvent extends PrexEvent {
  TogglePrexEvent({required this.prex});

  final PrexModel prex;

  @override
  List<Object?> get props => [prex];
}
