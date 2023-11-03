A Flutter widget that can take screen shots

## Features

#### A flutter widget that:

* Will ask for the Permission so you don't have to ask by yourself - You just have to add permissions for Android & iOS (Storage Permissions only)
* Will take the Global key as required param - You just have to enclose your desired widget inside the RePaint boundary and provide a unique Global key
* Will take the filename as required param - You can create the file name inside this package too ;)
* Will take the save directory - For Android you can set your desired directory, the default is Downloads

## Additional information

* Easy to use and manage
* You just have to provide your params
* Responds with a callback so you can know about your screen shot taken!

## Basic Setup

```
class MyExpandableWidget extends StatefulWidget {
  const MyExpandableWidget({super.key});

  @override
  State<MyExpandableWidget> createState() => _MyExpandableWidgetState();
}

class _MyExpandableWidgetState extends State<MyExpandableWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Expandi(
      expandableChildAnimationMilliSecondsDuration: 300,//optional
      onExpandCollapseCallback: (bool isExpanded) {
        setState(() {
          expanded = !isExpanded;
        });
      },
      isExpanded: expanded,
      headerWidget: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
        margin: const EdgeInsets.only(left: 20, right: 20),
        color: Colors.black,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
                child: Text(
              "Expand",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.end,
            ))
          ],
        ),
      ),
      expandableChild: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 12, right: 12),
        margin: const EdgeInsets.only(left: 20, right: 20),
        color: Colors.blue,
        child: const Text(
          "Hello world, greetings from the expandi, this would be a long journey!",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
```

## Constructor Example

```
const Expandi(
      {Key? key,
      this.expandableIconWidget,
      this.marginBetweenExpandableIcon = 0,
      required this.onExpandCollapseCallback,
      required this.headerWidget,
      required this.isExpanded,
      required this.expandableChild,
      this.expandableChildAnimationMilliSecondsDuration = 850,
      this.expandableIconAnimationMilliSecondsDuration = 500,
      this.headerWidgetEndPadding = 0})
```

<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
