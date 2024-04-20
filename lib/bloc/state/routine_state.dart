abstract class RoutineState {}

class RoutineLoadingState extends RoutineState {}

class RoutineLoadedState extends RoutineState {
  final List? mesRoutines;
  RoutineLoadedState({this.mesRoutines});
}

class RoutineErrorState extends RoutineState {
  final String error;
  RoutineErrorState(this.error);
}

class RoutineStoreDoneState extends RoutineState {
  final String message;
  RoutineStoreDoneState(this.message);
}