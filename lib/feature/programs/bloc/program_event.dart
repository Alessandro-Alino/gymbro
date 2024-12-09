part of 'program_bloc.dart';

sealed class ProgramEvent extends Equatable {}

class CreateProgramEvent extends ProgramEvent {
  @override
  List<Object?> get props => [];
}

class ReadProgramEvent extends ProgramEvent {
  @override
  List<Object?> get props => [];
}

class UpdateProgramEvent extends ProgramEvent {
  UpdateProgramEvent({required this.program});

  final ProgramModel program;

  @override
  List<Object?> get props => [program];
}

class DeleteProgramEvent extends ProgramEvent {
  DeleteProgramEvent({required this.program});

  final ProgramModel program;

  @override
  List<Object?> get props => [program];
}

class SelectProgramEvent extends ProgramEvent {
  SelectProgramEvent({required this.program});
  final ProgramModel program;

  @override
  List<Object?> get props => [program];
}

class UnSelectProgramEvent extends ProgramEvent {
  @override
  List<Object?> get props => [];
}
