import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<UserDetailsProvider>(
        create: (_) => UserDetailsProvider(),
        child: MyApp(),
      ),
    );

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: UserDetailsScreen(),
    );
  }
}

class UserDetailsProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  int _age = 0;
  String _userName = '';

  int get userAge => _age;
  String get userName => _userName;

  void updateAge(int age) {
    _age = age;
    notifyListeners();
  }

  void updateName(String name) {
    _userName = name;
    notifyListeners();
  }
}

class UserDetailsScreen extends StatelessWidget {
  UserDetailsScreen({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider State Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Enter Username and Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller:
                        context.read<UserDetailsProvider>().nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32),
                        ),
                      ),
                    ),
                    onChanged: (text) {
                      context.read<UserDetailsProvider>().updateName(text);
                    },
                    onFieldSubmitted: (text) {
                      context.read<UserDetailsProvider>().updateName(text);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller:
                        context.read<UserDetailsProvider>().ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32),
                        ),
                      ),
                    ),
                    onChanged: (text) {
                      context.read<UserDetailsProvider>().updateAge(
                            int.parse(text),
                          );
                    },
                    onFieldSubmitted: (text) {
                      context.read<UserDetailsProvider>().updateAge(
                            int.parse(text),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RawMaterialButton(
                      child: const Text(
                        'Save Details',
                        style: TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Sucessful'),
                            ),
                          );
                        }
                      },
                      fillColor: Colors.blue,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Consumer<UserDetailsProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    Text(
                      'Hi ' + provider.userName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'You are ' + provider.userAge.toString() + ' years old',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
