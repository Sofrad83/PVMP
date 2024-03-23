import 'package:pvmp/models/citation.dart';

abstract class CitationState {}

class CitationLoadingState extends CitationState {}

class CitationLoadedState extends CitationState {
  final Citation? citation;
  CitationLoadedState(this.citation);

  Citation? getCitation(){
    return citation;
  }
}

class CitationErrorState extends CitationState {
  final String error;
  CitationErrorState(this.error);
}