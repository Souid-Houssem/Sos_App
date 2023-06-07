import 'package:flutter/material.dart';
import 'package:oumayma/constants/global_context.dart';

class MediaQuerySize {
  static final mediaQuerySize =
      MediaQuery.of(NavigationService.currentContext!).size;
  static final height = mediaQuerySize.height;
  static final width = mediaQuerySize.width;
}
