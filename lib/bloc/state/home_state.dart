import 'package:pvmp/models/json_model.dart';

class HomeState {
  Json? citation;
  bool isError;
  bool isLoading;
  String? errorMessage;
  HomeState({this.citation, this.isError = false, this.isLoading = true, this.errorMessage});

  HomeState copyWith({
    Json? citation,
    bool? isLoading,
    bool? isError,
    String? errorMessage
  }){
    return HomeState(
      citation: citation ?? this.citation,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}