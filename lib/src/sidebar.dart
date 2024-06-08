import 'package:flutter/material.dart';

/// A sidebar that contains settings
class Sidebar extends StatelessWidget {
  /// Creates a sidebar
  const Sidebar({
    required this.backgroundColor,
    required this.virtualKeyboard,
    required this.onVirtualKeyboardChanged,
    super.key,
  });

  /// Background color of the sidebar
  final Color backgroundColor;

  /// If true, the virtual keyboard is shown
  final bool virtualKeyboard;

  /// Called when the virtual keyboard is toggled
  final ValueChanged<bool> onVirtualKeyboardChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      color: backgroundColor,
      textStyle: DefaultTextStyle.of(context).style,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: LayoutBuilder(
            builder: (context, constraints) => SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxHeight * 0.1,
              child: ListView(
                children: [
                  const Text('Virtual Keyboard'),
                  Switch.adaptive(
                    key: const ValueKey('virtualKeyboard switch'),
                    value: virtualKeyboard,
                    onChanged: onVirtualKeyboardChanged,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
