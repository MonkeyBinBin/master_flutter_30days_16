import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Registration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RegistrationFormPage(title: 'User Registration Page'),
    );
  }
}

class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({super.key, required this.title});
  final String title;

  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState<String>>();
  final _emailKey = GlobalKey<FormFieldState<String>>();
  final _passwordKey = GlobalKey<FormFieldState<String>>();
  final _genderKey = GlobalKey<FormFieldState<String>>();
  final _termsAcceptedKey = GlobalKey<FormFieldState<bool>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 120,
                height: 120,
              ),
              TextFormField(
                key: _nameKey,
                decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: Theme.of(context).colorScheme.primary),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                key: _emailKey,
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your name',
                    prefixIcon: const Icon(Icons.email),
                    prefixIconColor: Theme.of(context).colorScheme.primary),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                key: _passwordKey,
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.password),
                    prefixIconColor: Theme.of(context).colorScheme.primary),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: 16,
              ),
              FormField<String>(
                key: _genderKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                builder: (field) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.transgender,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const Text('Gender:'),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Male'),
                              value: 'Male',
                              groupValue: field.value,
                              onChanged: field.didChange),
                        ),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Female'),
                              value: 'Female',
                              groupValue: field.value,
                              onChanged: field.didChange),
                        ),
                      ],
                    ),
                    Text(
                      field.hasError ? field.errorText ?? '' : '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select gender';
                  }
                  return null;
                },
              ),
              FormField<bool>(
                key: _termsAcceptedKey,
                initialValue: false,
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                          title:
                              const Text('I accept the terms and conditions'),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: field.value,
                          onChanged: field.didChange),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          field.hasError ? field.errorText ?? '' : '',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
                validator: (value) {
                  if (value == null || value == false) {
                    return 'Please accept the terms and conditions';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Print form field values
                      if (kDebugMode) {
                        print('Name: ${_nameKey.currentState?.value}');
                        print('Email: ${_emailKey.currentState?.value}');
                        print('Password: ${_passwordKey.currentState?.value}');
                        print('Gender: ${_genderKey.currentState?.value}');
                        print(
                            'Terms Accepted: $_termsAcceptedKey.currentState?.value');
                      }

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Success'),
                                content: const Text(
                                    'Your registration was successful'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        _formKey.currentState?.reset();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'))
                                ],
                              ));
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
