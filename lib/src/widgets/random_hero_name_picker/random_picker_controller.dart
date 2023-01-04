import 'dart:ui';

class RandomPickerController {
  final List<VoidCallback> _listeners = [];

  final bool infiniteScroll;

  RandomPickerController({this.infiniteScroll = true});

  void addListener(VoidCallback listener) => _listeners.add(listener);

  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  void animate() {
    for (var callback in _listeners) {
      callback.call();
    }
    if (!infiniteScroll) {
      dispose();
    }
  }

  void dispose() => _listeners.clear();
}
