abstract class ExerciceState {}

class ExerciceLoadingState extends ExerciceState {
  final String? search;
  ExerciceLoadingState({this.search});
}

class ExerciceLoadedState extends ExerciceState {
  final List? mesExercices;
  ExerciceLoadedState({this.mesExercices});
}

class ExerciceErrorState extends ExerciceState {
  final String error;
  ExerciceErrorState(this.error);
}