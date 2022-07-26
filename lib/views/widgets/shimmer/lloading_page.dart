import 'package:flutter/material.dart';

class LoadAnimation extends StatefulWidget {
  final Widget child;

  const LoadAnimation({required this.child, Key? key}) : super(key: key);

  @override
  _LoadAnimationState createState() => _LoadAnimationState();
}

class _LoadAnimationState extends State<LoadAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        Positioned.fill(
          child: ClipRect(
              child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return FractionallySizedBox(
                widthFactor: .2,
                heightFactor: 0.9,
                alignment: AlignmentGeometryTween(
                  begin: const Alignment(-0.8 - .2 * 3, .0),
                  end: const Alignment(0.8 + .2 * 3, .0),
                )
                    .chain(CurveTween(curve: Curves.easeOut))
                    .evaluate(controller)!,
                child: child,
              );
            },
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(0, 255, 255, 255),
                    Colors.white24,
                  ],
                ),
              ),
            ),
          )),
        ),
      ],
    );
  }
}
