import 'package:pvmp/models/json_model.dart';

abstract class CitationState {}

class CitationLoadingState extends CitationState {}

class CitationLoadedState extends CitationState {
  final Json? citation;
  CitationLoadedState(this.citation);
}

class CitationErrorState extends CitationState {
  final String error;
  CitationErrorState(this.error);
}