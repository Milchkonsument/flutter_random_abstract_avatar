import 'package:flutter/material.dart';
import 'package:random_abstract_avatar/random_abstract_avatar.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  final _controller = TextEditingController(text: 'flutter!');

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          SizedBox(
              width: 200,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                controller: _controller,
              )),
          const SizedBox(width: 16),
          Avatar(
            source: _controller.text,
            size: 128,
            borderRadius: 32,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey),
            ),
            primitives: const [
              AvatarPrimitive.triangle,
              AvatarPrimitive.circle,
              AvatarPrimitive.square,
            ],
          ),
        ]))));
  }
}
