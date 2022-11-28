<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Features

一款简单易好用的刻度尺控件，自定义刻度显示，自定义样式

![](\tutieshi_580x180_13s.gif)

![](\tutieshi_580x188_8s.gif)

![](\tutieshi_580x200_14s.gif)

## Getting started

## Usage

```dart
RulerWidget(
size: Size(size.width, size.height / 5),
viewStyle: ViewStyle.valueUpScaleDownCloseStyle,
showHighScaleLine: true,
showHighScaleNum: true,
showLowScaleLine: true,
showLowScaleNum: true,
showMiddleScaleLine: true,
showMiddleScaleNum: true,
showLine: true,
textSize: 12,
zoomTextSize: 23,
startValue: 3,
endValue: 30,
initValue: 15,
space: 20,
scaleValueSpace: 10,
lowScaleLineColor: Colors.white,
middleScaleLineColor: Colors.amber,
highScaleLineColor: Colors.red,
lineColor: Colors.white,
lowScaleLineHigh: 30,
middleScaleLineHigh: 40,
highScaleLineHigh: 44,
middleScaleLineStrokeWidth: 2,
lowScaleLineStrokeWidth: 2,
highScaleLineStrokeWidth: 2,
lineStrokeWidth: 2,
textColor: Colors.white,
middleSpaceValueSpace: 5,
highSpaceValeSpace: 10,
)
```

| 属性                         | 类型        | 描述                                   |
| -------------------------- | --------- | ------------------------------------ |
| size                       | Size      | view尺寸                               |
| viewStyle                  | ViewStyle | 显示样式                                 |
| showHighScaleLine          | boolen    | 是否显示高刻度线                             |
| showHighScaleNum           | boolen    | 是否显示高刻度值                             |
| showLowScaleLine           | boolen    | 是否显示低刻度线                             |
| showLowScaleNum            | boolen    | 是否显示低刻度值                             |
| showMiddleScaleLine        | boolen    | 是否显示中刻度线                             |
| showMiddleScaleNum         | boolen    | 是否显示中刻度值                             |
| showLine                   | boolen    | 是否显示中间横线                             |
| textSize                   | num       | 刻度值文字大小                              |
| zoomTextSize               | num       | 刻度值放大文字大小                            |
| startValue                 | int       | 起始值                                  |
| endValue                   | int       | 结束值                                  |
| initValue                  | int       | 初始值                                  |
| space                      | double    | 刻度间距                                 |
| scaleValueSpace            | double    | 刻度和刻度值之间的间隔距离                        |
| lowScaleLineColor          | Color     | 低刻度线条颜色                              |
| middleScaleLineColor       | Color     | 中刻度线条颜色                              |
| highScaleLineColor         | Color     | 高刻度线条颜色                              |
| lineColor                  | Color     | 中间横线颜色                               |
| lowScaleLineHigh           | double    | 低刻度线高度                               |
| middleScaleLineHigh        | double    | 中刻度线高度                               |
| highScaleLineHigh          | double    | 高刻度线高度                               |
| middleScaleLineStrokeWidth | double    | 中刻度线宽度                               |
| lowScaleLineStrokeWidth    | double    | 低刻度线宽度                               |
| highScaleLineStrokeWidth   | double    | 高刻度线宽度                               |
| lineStrokeWidth            | double    | 中间线条宽度                               |
| textColor                  | Color     | 刻度值文字颜色                              |
| middleSpaceValueSpace      | int       | 相邻中刻度值间隔                             |
| highSpaceValeSpace         | int       | 相邻高刻度值间隔 |
