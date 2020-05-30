import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Slide Transition'),
          onPressed: () {
            Navigator.push(context, _createRoute());
          },
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Offset(0.0, 0.0) // replace
      // Offset(0.0, 1.0) // come from bottom
      // Offset(1.0, 0.0) // come from right
      // Offset(1.0, 1.0) // come from right|bottom
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var curveTween = CurveTween(curve: curve);
      var tween = Tween(begin: begin, end: end).chain(curveTween);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },

//    using CurvedAnimation
//    transitionsBuilder: (context, animation, secondaryAnimation, child) {
//      var begin = Offset(0.0, 1.0);
//      var end = Offset.zero;
//      var tween = Tween(begin: begin, end: end);
//      var curve = Curves.ease;
//      var curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
//
//      return SlideTransition(
//        position: tween.animate(curvedAnimation),
//        child: child,
//      );
//    },
  );
}

class Page2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.blue,
        child: Center(child: Text('Page 2')),
      ),
    );
  }
}
