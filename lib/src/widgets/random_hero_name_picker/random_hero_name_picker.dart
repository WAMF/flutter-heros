import 'package:flutter/material.dart';
import 'package:flutter_heros/src/widgets/random_hero_name_picker/random_picker_controller.dart';

class RandomHeroNamePicker extends StatefulWidget {
  final List<Widget> items;
  final int chosenIndex;
  final Duration duration;
  final double height;
  final RandomPickerController controller;
  final Curve curve;
  final AlignmentGeometry alignment;

  /// [speed] represents the amount of items scrolled through in a second;
  final int speed;

  const RandomHeroNamePicker({
    required this.items,
    required this.chosenIndex,
    required this.duration,
    required this.speed,
    required this.controller,
    this.curve = Curves.easeInOut,
    this.alignment = Alignment.center,
    this.height = 100.0,
    Key? key,
  }) : super(key: key);

  @override
  State<RandomHeroNamePicker> createState() => _RandomHeroNamePickerState();
}

class _RandomHeroNamePickerState extends State<RandomHeroNamePicker> {
  final ScrollController _scrollController = ScrollController();

  bool _animationIsActive = false;

  int get _itemCount => widget.duration.inMilliseconds * widget.speed ~/ 1000;

  @override
  void initState() {
    widget.controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  void _listener() async {
    if (!_animationIsActive) {
      _animationIsActive = true;
      await _scrollController.animateTo(
        _scrollController.offset + widget.height * _itemCount,
        duration: widget.duration,
        curve: widget.curve,
      );
      _animationIsActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SizedBox(
        height: widget.height,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          //itemCount: _itemCount + 1,
          itemBuilder: (_, index) {
            return Container(
              height: widget.height,
              alignment: widget.alignment,
              child: widget.items[(index - _itemCount + widget.chosenIndex) % widget.items.length],
            );
          },
        ),
      ),
    );
  }
}
