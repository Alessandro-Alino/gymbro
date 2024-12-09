part of 'program_bloc.dart';

final class ProgramState extends Equatable {
  final List<ProgramModel> programList;
  final ProgramModel? selectedProgram;

  const ProgramState({
    required this.programList,
    required this.selectedProgram,
  });

  // CopyWith method
  ProgramState copyWith({
    List<ProgramModel>? programList,
    ProgramModel? selectedProgram,
  }) =>
      ProgramState(
        programList: programList ?? this.programList,
        selectedProgram: selectedProgram,
      );

  @override
  List<Object?> get props => [programList, selectedProgram];
}
