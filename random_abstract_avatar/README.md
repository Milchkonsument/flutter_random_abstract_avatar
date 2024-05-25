[![plugin version](https://img.shields.io/pub/v/random_abstract_avatar?label=pub)](https://pub.dev/packages/random_abstract_avatar)
[![likes](https://img.shields.io/pub/likes/random_abstract_avatar?logo=dart)](https://pub.dev/packages/random_abstract_avatar/score)
[![pub points](https://img.shields.io/pub/points/random_abstract_avatar?logo=dart&color=teal)](https://pub.dev/packages/random_abstract_avatar/score)
[![popularity](https://img.shields.io/pub/popularity/random_abstract_avatar?logo=dart)](https://pub.dev/packages/random_abstract_avatar/score)

![Randomly Generated Abstract Avatars](https://i.imgur.com/yr8R8q7.png)
## GENERATE UNIQUE AND ABSTRACT USER AVATARS.

## Features
* ✨ **Highly Customizable:** allows for custom coloring and decorations
* ♻️ **Mix & Match:** choose which geometric shapes should be used for generation
* ✔️ **Offline:** since it doesn't use external services like [Gravatar](https://gravatar.com/), it fully works without an internet connection
* 🚀 **Fast:** with the help of [hashlib](https://pub.dev/packages/hashlib) and the dart UI canvas, avatar images get generated in an instant

## Getting Started
### Include in Project
```
import 'package:random_abstract_avatar/random_abstract_avatar.dart';
```

### Basic Widget
```
Avatar(source: 'test')
```

### Basic Example
```
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
                foregroundColor: Colors.pink,
                backgroundColor: Colors.black,
                size: 64,
              ),
            ]))));
  }
}
```

## Example Project
An example project can be found in the `example` folder of the repository.

## FAQ
* _I've set a gradient/decoration image, but it doesn't show, why?_
  * If you use box decoration for the avatar, make sure the `backgroundColor` is set to transparent, because it won't show otherwise.

## Contribution
Feel free to support me and work on open issues by making a pull request.

## Consider Donating
I'd be really grateful if you could support my work. Thanks.
[ko-fi](https://ko-fi.com/milchkonsument)
[paypal](https://www.paypal.com/paypalme/Milchbub)
