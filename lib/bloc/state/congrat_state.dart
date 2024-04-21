
class CongratState {
  double volume;

  CongratState({this.volume = 0.00});

  CongratState copyWith({
    double? volume
  }){
    return CongratState(
      volume: volume ?? this.volume
    );
  }
}