import 'dart:math';

import 'package:flutter/material.dart';
import 'package:media_query_preview/src/preview_cell.dart';
import 'package:media_query_preview/src/preview_device.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

/// A table that displays a preview of the app on multiple devices
class PreviewTable extends StatelessWidget {
  /// Creates a table that displays a preview of the app on multiple devices
  const PreviewTable({
    required this.previewDevices,
    required this.virtualKeyboard,
    required this.builder,
    super.key,
  });

  /// List of preview devices
  final List<List<PreviewDevice>> previewDevices;

  /// If true, the virtual keyboard is shown
  final bool virtualKeyboard;

  /// A builder that builds the preview of the app
  final Widget Function(
    BuildContext context,
    PreviewDevice previewDevice,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TableView.builder(
        columnCount: previewDevices.map((e) => e.length).reduce(max),
        rowCount: previewDevices.length,
        columnBuilder: (index) => TableSpan(
          extent: FixedTableSpanExtent(
            previewDevices.map(
              (e) {
                if (e.length <= index) {
                  return 0.0;
                }
                return e[index].size.width;
              },
            ).reduce(max),
          ),
        ),
        rowBuilder: (index) {
          final double extent;

          if (previewDevices.length <= index) {
            extent = 0.0;
          } else {
            extent = previewDevices[index]
                .map(
                  (e) => e.size.height,
                )
                .reduce(max);
          }

          return TableSpan(
            extent: FixedTableSpanExtent(extent),
          );
        },
        cellBuilder: (context, vicinity) {
          final devices = previewDevices[vicinity.row];

          final Widget child;

          if (devices.length <= vicinity.column) {
            child = const Center(
              child: Text('No device'),
            );
          } else {
            child = PreviewCell(
              previewDevice: devices[vicinity.column],
              virtualKeyboard: virtualKeyboard,
              builder: builder,
            );
          }

          return TableViewCell(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
