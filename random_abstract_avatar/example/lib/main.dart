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
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20),
                        Avatar(
                          source: _controller.text,
                          coloring: AvatarColoring.fromColors(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white),
                          layersCount: AvatarLayersCount.one,
                          borderRadius: i * 32,
                          sourceSize: 128,
                        ),
                        const SizedBox(width: 20),
                        Avatar(
                          source: _controller.text,
                          coloring: AvatarColoring.fromColors(
                            foregroundColor: Colors.greenAccent,
                            backgroundColor: Colors.black,
                            firstLayerColor: Colors.green,
                          ),
                          layersCount: AvatarLayersCount.two,
                          borderRadius: i * 32,
                          sourceSize: 128,
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(blurRadius: 12, color: Colors.greenAccent)
                          ]),
                        ),
                        const SizedBox(width: 20),
                        Avatar(
                          source: _controller.text,
                          coloring: AvatarColoring.fromColors(
                              foregroundColor: Colors.pink,
                              backgroundColor: Colors.black),
                          layersCount: AvatarLayersCount.three,
                          borderRadius: i * 32,
                          sourceSize: 128,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 4)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ).reduce((a, b) => b..addAll(a)),
              ),
            ]))));
  }
}
