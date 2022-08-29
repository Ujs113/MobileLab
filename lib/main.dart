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

class _UserFormState extends State<UserForm> {

    final _formKey = GlobalKey<FormState>();
	final usernameController = TextEditingController();
	final emailController = TextEditingController();

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
					validator: nullChecker,
				),
				ElevatedButton(onPressed: () {
					// if(_formKey.currentState!.validate()) {
					// 	ScaffoldMessenger.of(context).showSnackBar(
					// 		const SnackBar(content: Text('Loading...')),
					// 	);
					// }
					
					Navigator.push(context, MaterialPageRoute(builder: (context) => Display(username: usernameController.text, email: emailController.text)));
				}, child: const Text('Submit')),
			]),
		);
    }
}

class Display extends StatelessWidget {
	final String username, email;
	Display({Key? key, required this.username, required this.email}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('User Details'),
			),
			body: Column(
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
					
				],
			),
		);
	}
}