class RoutineState {
  final List? routines;
  final bool isError;
  final bool isLoading;
  final String? errorMessage;

  RoutineState({this.routines, this.isError = false, this.isLoading = true, this.errorMessage});

  RoutineState copyWith({
    List? routines,
    bool? isLoading,
    bool? isError,
    String? errorMessage
  }){
    return RoutineState(
      routines: routines ?? this.routines,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

}