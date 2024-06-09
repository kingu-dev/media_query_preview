import 'package:example/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_query_preview/media_query_preview.dart';

void main() {
  final container = ProviderContainer();

  // In release mode, we don't want to use the MediaQueryPreview
  // if (kReleaseMode) {
  //   runApp(
  //     UncontrolledProviderScope(
  //       container: container,
  //       child: const MyApp(
  //         targetPlatform: TargetPlatform.iOS,
  //       ),
  //     ),
  //   );
  //   return;
  // }

  final previewDevices = [
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
  ];

  // ignore: missing_provider_scope
  runApp(
    MediaQueryPreview(
      previewDevices: previewDevices,
      builder: (_, previewDevice) {
        // If you want to change the theme based on the targetPlatform,
        // you can get the targetPlatform from [previewDevice.targetPlatform].
        return UncontrolledProviderScope(
          container: container,
          child: const MyApp(),
        );
      },
    ),
  );

  // If you are not using riverpod, it is even simpler.
  // runApp(
  //   MediaQueryPreview(
  //     previewDevices: previewDevices,
  //     builder: (_, previewDevice) {
  //       // If you want to change the theme based on the targetPlatform,
  //       // you can get the targetPlatform from [previewDevice.targetPlatform].
  //       return const MyApp();
  //     },
  //   ),
  // );
}
