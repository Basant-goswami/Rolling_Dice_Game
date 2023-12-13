import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDice = 1;
  int rightDice = 1;
  late AnimationController _controller;
  late CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    // _controller.forward();
    animation.addListener(() {
      setState(() {
        // ye state change kar ke size ko controller ke value se update karta hai har baar
      });
      // print(animation.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // print("completed");
        setState(() {
          leftDice = Random().nextInt(6) + 1;
          rightDice = Random().nextInt(6) + 1;
        });
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }
  void text(){
    if(leftDice!=rightDice){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rolling Dice Game'),
        ),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: roll,
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Image(
                              height: 200 - (animation.value) * 200,
                              image: AssetImage(
                                  'assets/images/dice-png-$leftDice.png'))),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: roll,
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Image(
                              height: 200 - (animation.value) * 200,
                              image: AssetImage(
                                  'assets/images/dice-png-$rightDice.png'))),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: roll,
                  child: Text('Roll',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 168, 208, 240))))
            ],
          ),
        ));
  }
}
