[![pub package](https://img.shields.io/pub/v/media_query_preview.svg)](https://pub.dartlang.org/packages/media_query_preview)
[![GitHub deployments](https://img.shields.io/github/deployments/kingu-dev/media_query_preview/demo?label=Deploy%20Demo)](https://kingu-dev.github.io/media_query_preview/)

Have you ever experienced your UI breaking when the font size is too large or the screen size of the device is small? Checking for these issues can be a hassle.

This package allows you to preview how your implemented UI will appear on various devices with different screen sizes, text scales, and brightness.

It was inspired by [device_preview](https://pub.dev/packages/device_preview).

![Media Query Preview](https://raw.githubusercontent.com/kingu-dev/media_query_preview/main/screenshots/media_query_preview.gif)

## Features

This package provides the following features:

- Preview your UI on various devices with different screen sizes, text scales, and brightness.
- In addition to pre-defined devices like `PreviewDevice.iPhone5_5inch` and `PreviewDevice.android6_7inch`, you can create custom `PreviewDevice` instances.
- Preview your UI when the keyboard is displayed.
- Manipulate each preview individually.
- Friendly with [riverpod](https://pub.dev/packages/riverpod).

## Demo

Check out the demo at [https://kingu-dev.github.io/media_query_preview](https://kingu-dev.github.io/media_query_preview).

## Usage

If you are using [riverpod](https://pub.dev/packages/riverpod), you can do the following.

```dart
// Initialize Provider
final container = ProviderContainer();

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
```

If you are not using [riverpod](https://pub.dev/packages/riverpod), it is even simpler.

```dart
runApp(
  MediaQueryPreview(
    previewDevices: previewDevices,
    builder: (_, previewDevice) {
      // If you want to change the theme based on the targetPlatform,
      // you can get the targetPlatform from [previewDevice.targetPlatform].
      return const MyApp();
    },
  ),
);
```

## Attention

- It is recommended to use this package only development. Please do not use it in production.
- This package allows you to display multiple instances of the Widget you implemented at the same time, which may lead to poor performance or issues with state management.
- If you manage `GlobalKey` with global variables, they will be shared across each preview, which can lead to errors or unintended behavior. Since the widget trees of each preview are independent, it is recommended to generate a separate `GlobalKey` for each tree.

## Future

If you have Apple Vision Pro, you can use it as a "Designed for iPad" app. This is the future!

![Vision Pro](https://raw.githubusercontent.com/kingu-dev/media_query_preview/main/screenshots/vision_pro.webp)
