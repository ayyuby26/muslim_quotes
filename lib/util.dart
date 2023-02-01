import 'package:flutter/material.dart';

import 'main.dart';

double get width {
  final x = WidgetsBinding.instance.window;
  final r = MediaQueryData.fromWindow(x);
  return r.size.width;
}

double get height {
  final x = WidgetsBinding.instance.window;
  final r = MediaQueryData.fromWindow(x);
  return r.size.height;
}

void toast(msg) {
  final ctx = navigatorKey.currentContext;
  if (ctx == null) return;
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text("$msg")));
}

void onLoad(void Function() fun) {
  WidgetsBinding.instance.addPostFrameCallback((_) => fun());
}
