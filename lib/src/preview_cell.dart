import 'package:flutter/material.dart';
import 'package:media_query_preview/src/preview_device.dart';

/// A cell that displays a preview of the app on a device
class PreviewCell extends StatelessWidget {
  /// Creates a cell that displays a preview of the app on a device
  const PreviewCell({
    required this.previewDevice,
    required this.virtualKeyboard,
    required this.builder,
    super.key,
  });

  /// The height of the virtual keyboard
  static const double keyboardHeight = 214;

  /// The height of the status bar
  static const double statusBarHeight = 24;

  /// The height of the home indicator
  static const double homeIndicatorHeight = 34;

  /// A builder that builds the preview of the app
  final Widget Function(
    BuildContext context,
    PreviewDevice previewDevice,
  ) builder;

  /// The device to preview
  final PreviewDevice previewDevice;

  /// If true, the virtual keyboard is shown
  final bool virtualKeyboard;

  /// Calculates the padding for the MediaQuery
  EdgeInsets get padding {
    var insets = const EdgeInsets.only(
      top: statusBarHeight,
    );

    if (!virtualKeyboard && previewDevice.hasHomeIndicator) {
      insets += const EdgeInsets.only(
        bottom: homeIndicatorHeight,
      );
    }

    return insets;
  }

  /// Calculates the view insets for the MediaQuery
  EdgeInsets get viewInsets {
    return EdgeInsets.only(
      bottom: virtualKeyboard ? keyboardHeight : 0,
    );
  }

  /// Calculates the view padding for the MediaQuery
  EdgeInsets get viewPadding {
    var insets = const EdgeInsets.only(
      top: statusBarHeight,
    );

    if (previewDevice.hasHomeIndicator) {
      insets += const EdgeInsets.only(
        bottom: homeIndicatorHeight,
      );
    }

    return insets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(previewDevice.name),
        Text('Text Scale Factor: ${previewDevice.textScaleFactor}'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FittedBox(
              alignment: Alignment.topCenter,
              fit: BoxFit.scaleDown,
              child: LayoutBuilder(
                builder: (_, constraints) => SizedBox.fromSize(
                  size: previewDevice.size,
                  child: Column(
                    children: [
                      Expanded(
                        child: MediaQuery(
                          data: MediaQueryData(
                            platformBrightness: previewDevice.brightness,
                            size: previewDevice.size,
                            textScaler: TextScaler.linear(
                              previewDevice.textScaleFactor,
                            ),
                            padding: padding,
                            viewInsets: viewInsets,
                            viewPadding: viewPadding,
                          ),
                          child: Stack(
                            children: [
                              builder(context, previewDevice),
                              Visibility(
                                visible: virtualKeyboard,
                                child: Container(
                                  key: const ValueKey('virtualKeyboard'),
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    color: Colors.grey,
                                    height: keyboardHeight,
                                    width: double.infinity,
                                    child: const Center(
                                      child: Text('Keyboard'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
