import 'package:flutter/material.dart';

class FadeInZoomIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeInZoomIn({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  _FadeInZoomInState createState() => _FadeInZoomInState();
}

class _FadeInZoomInState extends State<FadeInZoomIn> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.fastOutSlowIn,
    ));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.fastOutSlowIn,
    ));

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation!.value,
          child: Transform.scale(
            scale: _scaleAnimation!.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
