part of 'prex_bloc.dart';

sealed class PrexState extends Equatable {}

class LoadingPrexState extends PrexState {
  @override
  List<Object?> get props => [];
}

class ErrorPrexState extends PrexState {
  ErrorPrexState({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}

class ListPrexState extends PrexState {
  ListPrexState({required this.prexList});

  final List<PrexModel> prexList;

  @override
  List<Object?> get props => [prexList];
}
