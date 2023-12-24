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
        theme: ThemeData.dark(useMaterial3: true),
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
              Avatar(
                source: _controller.text,
                coloring: AvatarColoring.fromColors(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white),
                layersCount: AvatarLayersCount.one,
                borderRadius: 32,
                sourceSize: 128,
              )
            ]))));
  }
}
