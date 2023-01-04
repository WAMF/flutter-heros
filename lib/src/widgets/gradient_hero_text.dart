import 'package:flutter/cupertino.dart';
import 'package:flutter_heros/src/utils/gradient_colors.dart';

class GradientHeroText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  late final Gradient gradient;
  final TextAlign textAlign;

  GradientHeroText.linear({
    required this.text,
    required GradientColors colors,
    this.style,
    this.textAlign = TextAlign.center,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
    Key? key,
  }) : super(key: key) {
    gradient = LinearGradient(
      colors: colors.data,
      begin: begin,
      end: end,
      stops: stops,
      tileMode: tileMode,
    );
  }

  GradientHeroText.radial({
    required this.text,
    required GradientColors colors,
    this.style,
    this.textAlign = TextAlign.center,
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
    Key? key,
  }) : super(key: key) {
    gradient = RadialGradient(
      colors: colors.data,
      center: center,
      stops: stops,
      radius: radius,
      tileMode: tileMode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
