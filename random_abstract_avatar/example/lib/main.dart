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
                child: SizedBox(
                    height: 1000,
                    width: 512,
                    child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                            ),
                            controller: _controller,
                          ),
                          const SizedBox(),
                          const SizedBox(),
                          const SizedBox(),
                          const SizedBox(),
                          const SizedBox(),
                          Avatar(
                            source: _controller.text,
                            size: 172,
                            borderRadius: 0,
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.redAccent,
                            primitives: const [AvatarPrimitive.circle],
                          ),
                          Avatar(
                            source: '${_controller.text}3-30r',
                            size: 172,
                            borderRadius: 64,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Colors.pink.shade100,
                                  Colors.blue.shade100
                                ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomRight)),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.grey,
                            primitives: const [AvatarPrimitive.triangle],
                          ),
                          Avatar(
                            source: '${_controller.text}d310',
                            size: 172,
                            borderRadius: 128,
                            decoration: const BoxDecoration(
                              boxShadow: [BoxShadow(blurRadius: 8)],
                            ),
                            backgroundColor: Colors.lime,
                            foregroundColor: Colors.grey.shade700,
                            primitives: const [
                              AvatarPrimitive.circle,
                              AvatarPrimitive.square
                            ],
                          ),
                          Avatar(
                            source: '${_controller.text}!!',
                            size: 172,
                            borderRadius: 0,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.purpleAccent, width: 3)),
                            backgroundColor: Colors.purple.shade900,
                            foregroundColor: Colors.purpleAccent,
                            primitives: const [
                              AvatarPrimitive.square,
                              AvatarPrimitive.triangle
                            ],
                          ),
                          Avatar(
                            source: '${_controller.text}!',
                            size: 172,
                            borderRadius: 64,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/marble.png'))),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.blueGrey.shade700,
                          ),
                          Avatar(
                            source: '${_controller.text}13-f',
                            size: 172,
                            borderRadius: 128,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.black),
                            ),
                            backgroundColor: Colors.grey.shade800,
                            foregroundColor: Colors.cyanAccent,
                          ),
                          Avatar(
                            source: '${_controller.text}fe',
                            size: 172,
                            borderRadius: 0,
                            decoration: BoxDecoration(
                              border: Border.all(width: 6, color: Colors.black),
                            ),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.amber,
                          ),
                          Avatar(
                            source: '${_controller.text}---',
                            size: 172,
                            borderRadius: 64,
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 8)
                            ]),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            complexity: AvatarComplexity.medium,
                          ),
                          Avatar(
                            source: '${_controller.text}f1-e',
                            size: 172,
                            borderRadius: 128,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/leaf.jpg'),
                                    fit: BoxFit.cover)),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            complexity: AvatarComplexity.medium,
                            primitives: const [
                              AvatarPrimitive.triangle,
                              AvatarPrimitive.circle
                            ],
                          ),
                        ])))));
  }
}
