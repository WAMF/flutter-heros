import 'package:flutter/animation.dart';

class RollInAnimation {
  final Tween tween;
  final void Function(Animation) onAnimationCreated;

  RollInAnimation({required this.tween, required this.onAnimationCreated});
}
