import 'package:flutter/material.dart';

class Exercise2 extends StatefulWidget {
  const Exercise2({Key? key}) : super(key: key);

  @override
  State<Exercise2> createState() => _Exercise2State();
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

class _Exercise2State extends State<Exercise2> {

  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final registerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 32.0,
              left: 32.0,
              right: 32.0
          ),
          child: Column(children: <Widget> [
            const Text('User Details', style: TextStyle(fontSize: 20)),
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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Registration Number'),
              validator: numberChecker,
            ),
            Center(
              child: ElevatedButton(onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      Display(username: usernameController.text,
                          email: emailController.text, reg: registerController.text)));
                }
              }, child: const Text('Submit')),
            ),
          ]),
        ),
      ),
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
}flutter/material.dart';

class Exercise2 extends StatelessWidget {
  const Exercise2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2'),
      ),
      body: const Text('Exercise 2'),
    );
  }
}