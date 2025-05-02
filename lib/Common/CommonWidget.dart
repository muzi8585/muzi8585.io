import 'dart:ui';

import 'package:flutter/material.dart';

class Commonwidget {
  void TopBarTitle(String title) {
    Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
    );
  }
}
