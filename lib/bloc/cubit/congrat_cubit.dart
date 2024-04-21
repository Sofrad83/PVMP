
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/state/congrat_state.dart';

class CongratCubit extends Cubit<CongratState> {
  CongratCubit() : super(CongratState());

  void setVolume({required double volume}){
    emit(state.copyWith(volume: volume));
  }
}