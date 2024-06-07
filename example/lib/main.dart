import 'package:example/my_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_query_preview/media_query_preview.dart';

void main() {
  final container = ProviderContainer();

  // In release mode, we don't want to use the MediaQueryPreview
  if (kReleaseMode) {
    runApp(
      UncontrolledProviderScope(
        container: ProviderContainer(
          parent: container,
        ),
        child: const MyApp(
          targetPlatform: TargetPlatform.iOS,
        ),
      ),
    );
    return;
  }

  // ignore: missing_provider_scope
  runApp(
    MediaQueryPreview(
      previewDevices: [
        [
          PreviewDevice.iPhone5_5inch(
            textScaleFactor: 0.5,
          ),
          PreviewDevice.iPhone5_5inch(),
          PreviewDevice.iPhone5_5inch(
            brightness: Brightness.dark,
          ),
          PreviewDevice.iPhone5_5inch(
            textScaleFactor: 1.5,
          ),
        ],
        [
          PreviewDevice.iPhone6_7inch(
            textScaleFactor: 0.5,
          ),
          PreviewDevice.iPhone6_7inch(),
          PreviewDevice.iPhone6_7inch(
            brightness: Brightness.dark,
          ),
          PreviewDevice.iPhone6_7inch(
            textScaleFactor: 1.5,
          ),
        ],
        [
          PreviewDevice.android6_7inch(
            textScaleFactor: 0.5,
          ),
          PreviewDevice.android6_7inch(),
          PreviewDevice.android6_7inch(
            brightness: Brightness.dark,
          ),
          PreviewDevice.android6_7inch(
            textScaleFactor: 1.5,
          ),
        ]
      ],
      builder: (_, previewDevice) => UncontrolledProviderScope(
        container: ProviderContainer(
          parent: container,
        ),
        child: MyApp(
          targetPlatform: previewDevice.targetPlatform,
        ),
      ),
    ),
  );
}
