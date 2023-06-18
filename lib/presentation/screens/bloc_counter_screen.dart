import 'package:bloc_exercises/presentation/blocs/counter_bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CounterBLoc(), child: const _BlocCounterView());
  }
}

class _BlocCounterView extends StatelessWidget {
  const _BlocCounterView({
    super.key,
  });

  void increaseCounterBy(BuildContext context, int value){
    context.read<CounterBLoc>().add(CounterIncreased(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select((CounterBLoc counterBloc) => Text("BLOC Counter: ${counterBloc.state.transaction}")),
        actions: [
          IconButton(onPressed: () => context.read<CounterBLoc>().add(CounterReset()), icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: Center(
        child: context.select((CounterBLoc counterBloc) => Text("Hola mundo ${counterBloc.state.counter}")),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            onPressed: () => increaseCounterBy(context, 3),
            child: const Text("+3"),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
              heroTag: '2', onPressed: () => increaseCounterBy(context, 2), child: const Text("+2")),
          const SizedBox(height: 15),
          FloatingActionButton(
              heroTag: '3', onPressed: () => increaseCounterBy(context, 1), child: const Text("+1"))
        ],
      ),
    );
  }
}
