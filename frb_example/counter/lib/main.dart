import 'package:counter/src/rust/api/app.dart';
import 'package:counter/src/rust/frb_generated.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Rust Bridge demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const CounterPage(
        title: 'Flutter Rust Bridge demo page',
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() {
    return _CounterState();
  }
}

class _CounterState extends State<CounterPage> {
  late final RustState state;
  late final BaseRustState baseState;

  @override
  void initState() {
    super.initState();
    state = RustState();
    baseState = BaseRustState(onMutate: () {
      if (mounted) setState(() {});
    });
    state.setBaseState(baseState: baseState);
  }

  void _increment() {
    setState(() {
      state.increment();
    });
  }

  @override
  void dispose() {
    baseState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '${state.count}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
