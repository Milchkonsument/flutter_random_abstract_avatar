![Randomly Generated Abstract Avatars](https://i.imgur.com/sgSN8BG.png)
## GENERATE UNIQUE AND ABSTRACT USER AVATARS.

### Features
* **Highly Customizable:** allows for custom coloring and decorations
* **Offline:** since it doesn't use external services like [Gravatar](https://gravatar.com/), it fully works without an internet connection
* **Fast:** with the help of [xxhash](https://github.com/Cyan4973/xxHash) and the dart UI canvas, avatar images get generated in an instant

### Getting Started
#### Basic Widget
```
Avatar(
                          source: 'test',
                          coloring: AvatarColoring.fromColors(
                              foregroundColor: Colors.pink,
                              backgroundColor: Colors.black),
                        ),
```

#### Avatar In Action
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
```

### Example Project
An example project can be found in the `example` folder of the repository.

#### Contribution
Feel free to support me and work on open issues by making a pull request.

#### Consider Donating
I'd be really grateful if you could support my work. Thanks.
[ko-fi](https://ko-fi.com/milchkonsument)
[paypal](https://www.paypal.com/paypalme/Milchbub)
