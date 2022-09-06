import 'package:flutter/material.dart';

void main() => runApp(const HelloWorld());

class HelloWorld extends StatelessWidget {
	const HelloWorld({super.key});

	@override
	Widget build(BuildContext context) {
		const appTitle = 'Hello World App';

		return MaterialApp(
			title: appTitle,
			home: Scaffold(
				appBar: AppBar(
					title: const Text(appTitle),
				),
				body: const UserForm(),
			)
		);
	}
}

class UserForm extends StatefulWidget {
	const UserForm({Key? key}) : super(key: key);

	@override
	State<UserForm> createState() => _UserFormState();
}

String? nullChecker(value) {
	if(value == null || value.isEmpty){
		return 'This is a required field';
	}
	return null;
}

String? emailChecker(value){
	final RegExp regex = RegExp(r"[a-zA-Z0-9]+@[a-zA-Z]+");
	if(!regex.hasMatch(value))
	{
		return '\nEnter a valid email';
	}
	return null;
}

bool isNumeric(String s) {
	return double.tryParse(s) != null;
}

String? numberChecker(value) {
	if(value == null || value.isEmpty){
		return 'This is a required field';
	}
	else if(!isNumeric(value))
	{
			return 'Please enter a number';
	}
	return null;
}

class _UserFormState extends State<UserForm> {

    final _formKey = GlobalKey<FormState>();
	final usernameController = TextEditingController();
	final emailController = TextEditingController();
	final registerController = TextEditingController();

    @override
    Widget build(BuildContext context) {
		return Form(
			key: _formKey,
			child: Column(children: <Widget> [
				TextFormField(
					controller: usernameController,
					decoration: const InputDecoration(labelText: 'Name'),
					validator: nullChecker,
				),
				TextFormField(
					controller: emailController,
					decoration: const InputDecoration(labelText: 'E- mail'),
					validator: emailChecker,
				),
				TextFormField(
					controller: registerController,
					decoration: const InputDecoration(labelText: 'Registration Number'),
					validator: numberChecker,
				),
				ElevatedButton(onPressed: () {
					if (_formKey.currentState!.validate()) {
						Navigator.push(context, MaterialPageRoute(builder: (context) =>
								Display(username: usernameController.text,
										email: emailController.text, reg: registerController.text)));
					}
				}, child: const Text('Submit')),
			]),
		);
    }
}

class Display extends StatelessWidget {
	final String username, email, reg;
	Display({Key? key, required this.username, required this.email, required this.reg}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('User Details'),
			),
			body: Center(
				child: Column(
					children: <Widget> [
						Text(
							username,
							style: const TextStyle(
								fontSize: 16,
								color: Colors.black,
							),
						),
						Text(
							email,
							style: const TextStyle(
								fontSize: 16,
								color: Colors.black,
							),
						),
						Text(
							reg,
							style: const TextStyle(
								fontSize: 16,
								color: Colors.black,
							),
						)
					],
				),
			),
		);
	}
}