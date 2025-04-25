import 'package:flutter/material.dart';
import 'package:movieapp/core/utils/utils.dart';

/// When user taps outside the textfield
/// and we wish if keyboard could be hide
/// this is the widget for your help

class KeyboardAwareWidget extends StatelessWidget {
  final Widget child;
  final Function? onTap;

  const KeyboardAwareWidget({
    required this.child,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
          Utils.unFocus(context);
        },
        child: child,
      );
}
