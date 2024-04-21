
import 'package:pvmp/models/json_model.dart';

class TrainingState {
  Json? routine;
  bool isLoading;
  bool isError;
  String? errorMessage;
  bool storeDone;
  double? volume;

  TrainingState({this.routine, this.isLoading = true, this.isError = false, this.errorMessage, this.storeDone = false, this.volume});

  TrainingState copyWith({
    Json? routine,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    bool? storeDone,
    double? volume
  }){
    return TrainingState(
      routine: routine ?? this.routine,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      storeDone: storeDone ?? this.storeDone,
      volume: volume ?? this.volume
    );
  }
}