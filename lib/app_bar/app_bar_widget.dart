import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradients {
  static final linear = LinearGradient(colors: [
    Colors.amber,
    Colors.yellow,
  ], stops: [
    0.3,
    0.900
  ], transform: GradientRotation(2.13959913 * pi));
}
