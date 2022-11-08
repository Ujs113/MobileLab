import 'package:flutter/material.dart';

class Exercise7 extends StatefulWidget {
  const Exercise7({Key? key}) : super(key: key);

  @override
  State<Exercise7> createState() => _Exercise7State();
}

class _Exercise7State extends State<Exercise7> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(onPressed: _incrementCounter, tooltip: 'Increment', child: new Icon(Icons.add)),
    );
  }
}
