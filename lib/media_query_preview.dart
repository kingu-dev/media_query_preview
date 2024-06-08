import 'package:flutter/material.dart';
import 'package:media_query_preview/src/preview_device.dart';
import 'package:media_query_preview/src/preview_table.dart';
import 'package:media_query_preview/src/sidebar.dart';

export 'package:media_query_preview/src/preview_device.dart';

/// A widget that displays a preview of the app on multiple devices
class MediaQueryPreview extends StatefulWidget {
  /// Creates a widget that displays a preview of the app on multiple devices
  MediaQueryPreview({
    required this.previewDevices,
    required this.builder,
    super.key,
    this.backgroundColor = const Color(0xFF042B59),
    this.virtualKeyboard = false,
  }) : assert(previewDevices.isNotEmpty, 'previewDevices is empty');

  /// List of preview devices
  final List<List<PreviewDevice>> previewDevices;

  /// Default background color is the same as Flutter's brand color
  /// https://flutter.dev/brand
  final Color backgroundColor;

  /// If true, the virtual keyboard is shown
  final bool virtualKeyboard;

  /// A builder that builds the preview of the app
  final Widget Function(
    BuildContext context,
    PreviewDevice previewDevice,
  ) builder;

  @override
  State<MediaQueryPreview> createState() => _MediaQueryPreviewState();
}

class _MediaQueryPreviewState extends State<MediaQueryPreview> {
  bool virtualKeyboard = false;

  @override
  void initState() {
    virtualKeyboard = widget.virtualKeyboard;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        key: const ValueKey('MediaQueryPreview Scaffold'),
        backgroundColor: widget.backgroundColor,
        body: DefaultTextStyle(
          key: const ValueKey('MediaQueryPreview DefaultTextStyle'),
          style: TextStyle(
            color: widget.backgroundColor.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white,
          ),
          child: Row(
            children: [
              Sidebar(
                backgroundColor: widget.backgroundColor,
                virtualKeyboard: virtualKeyboard,
                onVirtualKeyboardChanged: (value) {
                  setState(() {
                    virtualKeyboard = value;
                  });
                },
              ),
              Expanded(
                child: PreviewTable(
                  previewDevices: widget.previewDevices,
                  virtualKeyboard: virtualKeyboard,
                  builder: widget.builder,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
