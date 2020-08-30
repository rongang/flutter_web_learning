import 'package:flutter/material.dart';

class AnimatedIconDemo extends StatefulWidget {
  @override
  _AnimatedIconDemoState createState() => _AnimatedIconDemoState();
}

class _AnimatedIconDemoState extends State<AnimatedIconDemo>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..forward();
    animation = Tween().animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: AnimatedIcon(
                icon: AnimatedIcons.arrow_menu,
                progress: animationController,
                size: 100,
              ),
              onTap: (){
                if(animationController.value==1.0)
                  animationController.reverse(from: 1.0);
                else
                  animationController.forward(from: 0.0);
              },
            )
          ],
        ),
      ),
    );
  }
}
