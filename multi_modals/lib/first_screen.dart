import 'package:flutter/material.dart';
import 'package:page_route_builder_practice/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String _modalMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiple Modal Example')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const SizedBox(height: 200),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Hero(
                        tag: 'user_avatar',
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.amber,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const FlutterLogo(),
                        ),
                      ),
                      const Text(
                        'Allen Abbott',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _modalMessage = await showMultiModal(context: context);
                      setState(() {});
                    },
                    child: const Text('Open multi modals'),
                  ),
                  if (_modalMessage != '')
                    Text('Modal Message: $_modalMessage'),
                ],
              ),
              const SizedBox(height: 1000),
            ],
          ),
        ),
      ),
    );
  }
}

Future<T?> showMultiModal<T>({required BuildContext context}) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: const Duration(seconds: 1),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      opaque: false,
      pageBuilder: (_, __, ____) => const SecondScreen(),
    ),
  );
}
