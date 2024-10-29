import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/counter_service.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterService>(builder: (context, counter, child) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Button tapped ${counter.value} time${counter.value == 1 ? '' : 's'}.\n\n'
                'This should persist across restarts.',
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: counter.increment, tooltip: 'Increment', child: const Icon(Icons.add)),
      );
    });
  }
}
