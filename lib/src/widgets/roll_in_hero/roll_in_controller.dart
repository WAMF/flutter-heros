import 'package:flutter/cupertino.dart';
import 'package:flutter_heros/src/widgets/roll_in_hero/roll_in_animation.dart';

class RollInController {
  final List<RollInAnimation> _animations = [];
  final Curve curve;
  final TickerProvider vsync;
  final Duration duration;

  late final AnimationController _animationController;

  bool _animationsInitialized = false;

  RollInController({
    required this.vsync,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  void addAnimation({required RollInAnimation animation}) {
    if (_animationsInitialized) {
      throw (FlutterError('Animations can not be added after you used controller'));
    } else {
      _animations.add(animation);
    }
  }

  Future<void> forward() async {
    _initIfNeeded();
    return _animationController.forward();
  }

  Future<void> stop() async {
    _initIfNeeded();
    return _animationController.stop();
  }

  Future<void> reverse() async {
    _initIfNeeded();
    return _animationController.reverse();
  }

  Future<void> reset() async {
    _initIfNeeded();
    return _animationController.reset();
  }

  void _initIfNeeded() {
    if (!_animationsInitialized) {
      _initAnimations();
      _animationsInitialized = true;
    }
  }

  void _initAnimations() {
    final step = 1 / _animations.length;

    _animationController = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: duration.inMilliseconds * _animations.length),
    );

    for (var i = 0; i < _animations.length; i++) {
      final animation = _animations[i];

      animation.onAnimationCreated(
        animation.tween.animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(
              i * step,
              (i + 1) * step,
              curve: curve,
            ),
          ),
        ),
      );
    }
  }

  void dispose() {
    _animations.clear();
    _animationController.dispose();
  }
}
