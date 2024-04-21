class SelectExerciceState {
  List? exercices;
  String? search;
  bool isError;
  bool isLoading;
  String? errorMessage;
  SelectExerciceState({this.exercices, this.isError = false, this.isLoading = true, this.errorMessage, this.search});

  SelectExerciceState copyWith({
    List? exercices,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    String? search
  }){
    return SelectExerciceState(
      exercices: exercices ?? this.exercices,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      search: search ?? this.search
    );
  }
}