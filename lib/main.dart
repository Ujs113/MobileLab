import 'package:flutter/material.dart';

import 'exercise_1.dart';
import 'exercise_2.dart';
import 'exercise_3.dart';
import 'exercise_4.dart';

void main() => runApp(const HelloWorld());

class HelloWorld extends StatelessWidget {
	const HelloWorld({super.key});

	@override
	Widget build(BuildContext context) {
		const appTitle = 'Mobile App Development Lab';

		return MaterialApp(
			title: appTitle,
			home: Scaffold(
				appBar: AppBar(
					title: const Text(appTitle),
				),
				body: const Index(),
			)
		);
	}
}

// List exercises = [['Exercise 1', Exercise1()], ['Exercise 2', Exercise2()]];
List exercises = [['Exercise 2', Exercise2()], ['Exercise 3', Exercise3()], ['Exercise 4', Exercise4()]];

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
			padding: const EdgeInsets.all(16.0),
			itemCount: exercises.length,
			itemBuilder: (context, i) {
				return GestureDetector(
					child: ListTile(title: Text(exercises[i][0])),
					onTap: () {
						Navigator.push(context, MaterialPageRoute(
							builder: (context) => exercises[i][1]
						));
					}
				);
			},
		);
  }
}