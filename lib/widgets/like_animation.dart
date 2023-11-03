import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final bool smallLike;
  final VoidCallback? onEnd;
  const LikeAnimation(
      {Key? key,
      required this.child,
      required this.isAnimating,
      this.duration = const Duration(milliseconds: 300),
      this.smallLike = false,
      this.onEnd})
      : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMicroseconds ~/ 2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }


  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  Future<dynamic> startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      controller.forward().whenComplete(() => Future.delayed(const Duration(milliseconds: 150)));
      await controller.reverse();
      await Future.delayed(const Duration(milliseconds: 400));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }


    }
  }


  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
