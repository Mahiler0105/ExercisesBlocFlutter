part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counter;
  final int transaction;

  const CounterState({this.counter = 0, this.transaction = 0});

  copyWith({int? counter, int? transaction}) => CounterState(
      counter: counter ?? this.counter,
      transaction: transaction ?? this.transaction);

  @override
  List<Object?> get props => [counter, transaction];
}
