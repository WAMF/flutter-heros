import 'package:flutter/material.dart';
import 'package:flutter_heros/src/widgets/roll_in_hero/roll_in_animation.dart';
import 'package:flutter_heros/src/widgets/roll_in_hero/roll_in_controller.dart';

enum RollInDirection { rightToLeft, leftToRight, topToBottom, bottomToTop }

class RollInHero extends StatefulWidget {
  final RollInDirection direction;
  final RollInController controller;
  final Widget child;

  const RollInHero({
    this.direction = RollInDirection.bottomToTop,
    required this.controller,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<RollInHero> createState() => _RollInHeroState();
}

class _RollInHeroState extends State<RollInHero> {
  static const double _initialAnimationValue = 1.0;
  final GlobalKey _widgetKey = GlobalKey();

  Animation? _animation;
  Size? _childSize;

  bool get _childShown => _animation?.value != _initialAnimationValue;

  @override
  void initState() {
    widget.controller.addAnimation(
      animation: RollInAnimation(
        tween: Tween<double>(begin: _initialAnimationValue, end: 0),
        onAnimationCreated: (animation) => setState(() => _animation = animation),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_animation == null) {
      return Transform.translate(
        offset: _getScrollOffset(MediaQuery.of(context).size),
        child: Opacity(
          opacity: _childShown ? 1.0 : 0.0,
          child: widget.child,
        ),
      );
    } else {
      return AnimatedBuilder(
        key: _widgetKey,
        animation: _animation!,
        builder: (context, child) {
          return Transform.translate(
            offset: _getScrollOffset(MediaQuery.of(context).size),
            child: Opacity(
              opacity: _childShown ? 1.0 : 0.0,
              child: widget.child,
            ),
          );
        },
      );
    }
  }

  Offset _getScrollOffset(Size screenSize) {
    final globalOffset = _getGlobalOffset();
    final Size size;
    final animationValue = _animation?.value ?? _initialAnimationValue;

    if (_childSize == null) {
      size = _getSize();
      if (size != Size.zero) {
        _childSize = size;
      }
    } else {
      size = _childSize!;
    }

    switch (widget.direction) {
      case RollInDirection.rightToLeft:
        return Offset((screenSize.width - globalOffset.dx) * animationValue, 0);
      case RollInDirection.leftToRight:
        return Offset(-(globalOffset.dx + size.width) * animationValue, 0);
      case RollInDirection.bottomToTop:
        return Offset(0, (screenSize.height - globalOffset.dy) * animationValue);
      case RollInDirection.topToBottom:
        return Offset(0, -(globalOffset.dy + size.height) * animationValue);
    }
  }

  Offset _getGlobalOffset() {
    final renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
  }

  Size _getSize() {
    final renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size ?? Size.zero;
  }
}
