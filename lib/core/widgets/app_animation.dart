import 'package:flutter/material.dart';

///this class use only when widget child changes.
///switcher, checkboxes, radio buttons, etc.
import 'package:flutter/material.dart';
import 'dart:math';

class AppAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final bool useFade;
  final bool useScale;
  final bool useRotation;
  final bool useSlide;
  final Axis slideAxis;
  final bool useBottomToTop;
  final bool useGlow;
  final bool useFlip;

  const AppAnimatedSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
    this.useFade = true,
    this.useScale = false,
    this.useRotation = false,
    this.useSlide = false,
    this.slideAxis = Axis.horizontal,
    this.useBottomToTop = false,
    this.useGlow = false,
    this.useFlip = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return _buildTransitions(child, animation);
      },
      child: child,
    );
  }

  Widget _buildTransitions(Widget child, Animation<double> animation) {
    Widget current = child;

    if (useFade) {
      current = FadeTransition(opacity: animation, child: current);
    }

    if (useScale) {
      current = ScaleTransition(scale: animation, child: current);
    }

    if (useRotation) {
      current = RotationTransition(
        turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: current,
      );
    }

    if (useSlide || useBottomToTop) {
      final Offset begin =
          useBottomToTop
              ? const Offset(0, 1)
              : slideAxis == Axis.horizontal
              ? const Offset(1.0, 0.0)
              : const Offset(0.0, 1.0);
      current = SlideTransition(
        position: Tween<Offset>(
          begin: begin,
          end: Offset.zero,
        ).animate(animation),
        child: current,
      );
    }

    if (useFlip) {
      current = AnimatedBuilder(
        animation: animation,
        child: current,
        builder: (context, child) {
          final angle = animation.value * pi;
          final isUnder = angle > pi / 2;
          return Transform(
            transform: Matrix4.rotationY(angle),
            alignment: Alignment.center,
            child: isUnder ? Opacity(opacity: 0.0, child: child) : child,
          );
        },
      );
    }

    if (useGlow) {
      current = TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.5, end: 1.0),
        duration: const Duration(seconds: 1),
        builder:
            (context, opacity, child) =>
                Opacity(opacity: opacity, child: child),
        child: current,
      );
    }

    return current;
  }
}

//========================================================================================================================================

class AppAnimationList extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool useBottomToTop;
  final bool useFade;
  final bool useScale;
  final bool useRotation;
  final bool useSlide;
  final Axis slideAxis;
  final bool useGlow;
  final bool useFlip;

  const AppAnimationList({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.useFade = true,
    this.useScale = false,
    this.useRotation = false,
    this.useSlide = false,
    this.useBottomToTop = false,
    this.useGlow = false,
    this.slideAxis = Axis.horizontal,
    this.useFlip = false,
  });

  @override
  State<AppAnimationList> createState() => _AppAnimationListState();
}

class _AppAnimationListState extends State<AppAnimationList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  Animation<double>? _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    if (widget.useGlow) {
      _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_animation)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        });
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedChild() {
    Widget current = widget.child;

    if (widget.useFade) {
      current = FadeTransition(opacity: _animation, child: current);
    }

    if (widget.useScale) {
      current = ScaleTransition(scale: _animation, child: current);
    }

    if (widget.useRotation) {
      current = RotationTransition(
        turns: Tween<double>(begin: 0.5, end: 1.0).animate(_animation),
        child: current,
      );
    }

    if (widget.useSlide || widget.useBottomToTop) {
      final beginOffset =
          widget.useBottomToTop
              ? const Offset(0, 1)
              : widget.slideAxis == Axis.horizontal
              ? const Offset(1, 0)
              : const Offset(0, 1);
      current = SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset,
          end: Offset.zero,
        ).animate(_animation),
        child: current,
      );
    }

    if (widget.useFlip) {
      current = AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;

          // Apply perspective for 3D effect
          final transform =
              Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle);

          // Prevent mirrored content by flipping again after 90°
          Widget content = widget.child;
          if (angle > pi / 2) {
            content = Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: content,
            );
          }

          return Transform(
            alignment: Alignment.center,
            transform: transform,
            child: content,
          );
        },
      );
    }

    if (widget.useGlow && _glowAnimation != null) {
      current = AnimatedBuilder(
        animation: _glowAnimation!,
        builder:
            (context, child) =>
                Opacity(opacity: _glowAnimation!.value, child: child),
        child: current,
      );
    }

    return current;
  }

  @override
  Widget build(BuildContext context) => _buildAnimatedChild();
}
