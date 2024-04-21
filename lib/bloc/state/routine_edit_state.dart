class RoutineEditState {
  int? id;
  bool needToInit;
  bool isError;
  String? errorMessage;
  bool storeDone;
  String? storeMessage;

  RoutineEditState({this.isError = false, this.errorMessage, this.id, this.needToInit = true, this.storeDone = false, this.storeMessage});

  RoutineEditState copyWith({
    int? id,
    bool? needToInit,
    bool? isError,
    String? errorMessage,
    bool? storeDone,
    String? storeMessage,
  }){
    return RoutineEditState(
      id: id ?? this.id,
      needToInit: needToInit ?? this.needToInit,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      storeDone: storeDone ?? this.storeDone,
      storeMessage: storeMessage ?? this.storeMessage
    );
  }

}