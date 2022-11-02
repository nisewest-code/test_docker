import 'package:flutter/material.dart';

class DialogUtil{
  static Future<bool?> showBottomSheet(BuildContext context, Widget widget) async {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}