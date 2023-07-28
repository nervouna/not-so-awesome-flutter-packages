import 'package:flutter/material.dart';

extension QuickNavigating on BuildContext {
  Future<T?> pushPage<T>(Widget page) =>
      Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));

  Future<T?> pushFullscreenPage<T>(Widget page) => Navigator.of(this)
      .push<T>(MaterialPageRoute(builder: (_) => page, fullscreenDialog: true));

  void popPage<T>(T? result) => Navigator.of(this).pop<T>(result);
}
