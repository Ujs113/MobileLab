import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

int calculate(int val) {
  int sum = 0;
  for(int i = 0; i < val; i++) {
    sum += i;
  }
  return sum;
}

class Exercise7 extends StatefulWidget {
  const Exercise7({Key? key}) : super(key: key);

  @override
  State<Exercise7> createState() => _Exercise7State();
}

class _Exercise7State extends State<Exercise7> {
  int _counter = 0;
  String _answer = '';
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> onpressed() async {
    int val=0;
    setState(() {
      _answer = 'Computing.....';
    }); 
    val = await compute(calculate, 1000000000); 
    _answer = val.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 7 - Multithreading')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            new Text(
              'Current counter: ',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            ElevatedButton(onPressed: onpressed, child: const Text('Calculate sum')),
            new Text(
              'Computed answer: $_answer'
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(onPressed: _incrementCounter, tooltip: 'Increment', child: new Icon(Icons.add)),

    );
  }
}
