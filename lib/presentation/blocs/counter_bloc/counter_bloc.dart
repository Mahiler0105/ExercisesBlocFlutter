import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';
part 'counter_event.dart';

class CounterBLoc extends Bloc<CounterEvent, CounterState> {
  CounterBLoc() : super(const CounterState()) {
    on<CounterIncreased>(onCounterIncreased);
    on<CounterReset>(onCounterReset);
  }

  void onCounterIncreased(CounterIncreased event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      counter: state.counter + event.value,
      transaction: state.transaction + 1,
    ));
  }

  void onCounterReset(CounterReset event, Emitter<CounterState> emit) {
    emit(state.copyWith(
      counter: 0,
    ));
  }
}
