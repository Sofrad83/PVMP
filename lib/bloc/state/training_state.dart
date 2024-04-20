
import 'package:pvmp/models/json_model.dart';

abstract class TrainingState {}

class TrainingLoadingState extends TrainingState {}

class TrainingLoadedState extends TrainingState {
  Json routine;
  TrainingLoadedState({required this.routine});
}

class TrainingErrorState extends TrainingState {
  final String error;
  TrainingErrorState(this.error);
}

class TrainingStoreDoneState extends TrainingState {
  final double volumeLastSeance;
  TrainingStoreDoneState({required this.volumeLastSeance});
}