import 'package:pvmp/models/json_model.dart';

class ChooseRoutineState {
  List? routines;
  bool isError;
  bool isLoading;
  String? errorMessage;
  ChooseRoutineState({this.routines, this.isError = false, this.isLoading = true, this.errorMessage});

  ChooseRoutineState copyWith({
    List? routines,
    bool? isLoading,
    bool? isError,
    String? errorMessage
  }){
    return ChooseRoutineState(
      routines: routines ?? this.routines,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}