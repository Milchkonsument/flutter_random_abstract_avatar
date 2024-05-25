import 'package:flutter/material.dart';
import 'package:random_abstract_avatar/random_abstract_avatar.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatefulWidget {
  const TestApp({super.key});

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
                child: Row(children: [
      SizedBox(
        width: 200,
        child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
          ),
          controller: _controller,
        ),
      ),
      const SizedBox(width: 16),
      Avatar(
        source: _controller.text,
        size: 64,
        borderRadius: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.redAccent,
        primitives: const [AvatarPrimitive.circle],
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8)],
        ),
      ),
      const SizedBox(width: 16),
      Avatar(
        source: '${_controller.text}3-30r',
        size: 64,
        borderRadius: 8,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pink.shade100, Colors.blue.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight),
          boxShadow: const [BoxShadow(blurRadius: 8)],
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        primitives: const [AvatarPrimitive.triangle],
      ),
      const SizedBox(width: 16),
      Avatar(
        source: '${_controller.text}d310',
        size: 64,
        borderRadius: 16,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/marble.png')),
          boxShadow: [BoxShadow(blurRadius: 8)],
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade700,
        primitives: const [AvatarPrimitive.circle, AvatarPrimitive.square],
      ),
      const SizedBox(width: 16),
      Avatar(
        source: '${_controller.text}ofies39q',
        size: 64,
        borderRadius: 24,
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8)],
        ),
        backgroundColor: Colors.lime,
        foregroundColor: Colors.grey.shade700,
        primitives: const [AvatarPrimitive.circle, AvatarPrimitive.square],
      ),
      const SizedBox(width: 16),
      Avatar(
        source: '${_controller.text}ererre',
        size: 64,
        borderRadius: 32,
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8)],
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.purpleAccent,
        primitives: const [AvatarPrimitive.circle, AvatarPrimitive.square],
      ),
    ]))));
  }
}
