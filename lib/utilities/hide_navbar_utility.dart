import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HideNavbarUtility {
  final ScrollController _controller = ScrollController();
  final ValueNotifier<bool> _visible = ValueNotifier<bool>(true);

  static final HideNavbarUtility _instance = HideNavbarUtility._();

  HideNavbarUtility._() {
    _visible.value = true;
    _controller.addListener(
      () {
        if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
          if (_visible.value) {
            _visible.value = false;
          }
        }
        if (_controller.position.userScrollDirection == ScrollDirection.forward) {
          if (!_visible.value) {
            _visible.value = true;
          }
        }
      },
    );
  }

  static HideNavbarUtility get instance => _instance;

  ScrollController get getController {
    return _controller;
  }

  ValueNotifier<bool> get getVisisble {
    return _visible;
  }

  void dispose() {
    _controller.dispose();
    _visible.dispose();
  }
}
