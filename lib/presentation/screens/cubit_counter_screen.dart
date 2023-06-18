import 'package:bloc_exercises/presentation/blocs/counter_cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CounterCubit(),
        child: const _CubitCounterView());
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final counterState = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cubit Counter: ${counterState.transaction}"),
        actions: [
          IconButton(onPressed: () => context.read<CounterCubit>().reset(), icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          builder: (context , state){
            return Text("Hola mundo ${state.counter}");
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            onPressed: () => context.read<CounterCubit>().increaseBy(3),
            child: const Text("+3"),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
              heroTag: '2', onPressed: () => context.read<CounterCubit>().increaseBy(2), child: const Text("+2"),),
          const SizedBox(height: 15),
          FloatingActionButton(
              heroTag: '3', onPressed: () => context.read<CounterCubit>().increaseBy(1), child: const Text("+1"))
        ],
      ),
    );
  }
}
