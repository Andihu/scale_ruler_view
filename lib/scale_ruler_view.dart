import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewStyle {
  int viewStyle = 0;

  ViewStyle(this.viewStyle);

  static ViewStyle valueDownScaleUpStyle = ViewStyle(1);

  static ViewStyle valueUpScaleDownStyle = ViewStyle(2);

  static ViewStyle valueDownScaleUpCloseStyle = ViewStyle(3);

  static ViewStyle valueUpScaleDownCloseStyle = ViewStyle(4);
}

typedef ScaleValueChangeCallback = void Function(int value);

class RulerWidget extends StatefulWidget {
  RulerWidget({
    Key? key,
    required this.size,
    required this.viewStyle,
    required this.startValue,
    required this.endValue,
    required this.initValue,
    required this.scaleValueSpace,
    required this.lowScaleLineHigh,
    required this.middleScaleLineHigh,
    required this.highScaleLineHigh,
    required this.space,
    required this.textSize,
    required this.textColor,
    required this.zoomTextSize,
    required this.lowScaleLineColor,
    required this.middleScaleLineColor,
    required this.highScaleLineColor,
    required this.lowScaleLineStrokeWidth,
    required this.middleScaleLineStrokeWidth,
    required this.highScaleLineStrokeWidth,
    required this.showLowScaleLine,
    required this.showMiddleScaleLine,
    required this.showHighScaleLine,
    required this.showLowScaleNum,
    required this.showMiddleScaleNum,
    required this.showHighScaleNum,
    required this.highSpaceValeSpace,
    required this.middleSpaceValueSpace,
    required this.lineColor,
    required this.showLine,
    required this.lineStrokeWidth,
    required this.callback,
  }) : super(key: key);
  Size size;
  var startValue = 3;
  var endValue = 30;
  var initValue = 10;
  double scaleValueSpace = 20;
  double lowScaleLineHigh = 20;
  double middleScaleLineHigh = 40;
  double highScaleLineHigh = 50;
  late ViewStyle viewStyle;
  double space = 60;
  double textSize = 14;
  Color textColor = Colors.black45;
  double zoomTextSize = 20;
  Color lowScaleLineColor;
  Color middleScaleLineColor;
  Color highScaleLineColor;
  double lowScaleLineStrokeWidth;
  double middleScaleLineStrokeWidth;
  double highScaleLineStrokeWidth;
  bool showLowScaleLine;
  bool showMiddleScaleLine;
  bool showHighScaleLine;
  bool showLowScaleNum;
  bool showMiddleScaleNum;
  bool showHighScaleNum;
  int middleSpaceValueSpace;
  int highSpaceValeSpace;
  bool showLine;
  double lineStrokeWidth;
  Color lineColor;
  ScaleValueChangeCallback callback;

  @override
  _RulerWidgetState createState() => _RulerWidgetState();
}

class _RulerWidgetState extends State<RulerWidget> with TickerProviderStateMixin {
  late double _leftXAxis;
  late double _rightXAxis;

  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    _leftXAxis = -widget.space * (widget.initValue - widget.startValue);
    _rightXAxis = widget.space * (widget.endValue - widget.initValue);

    return GestureDetector(
      child: CustomPaint(
        size: widget.size,
        painter: RulerView(
          offset: _offsetX,
          textSize: widget.textSize,
          zoomTextSize: widget.zoomTextSize,
          middleScaleLineHigh: widget.middleScaleLineHigh,
          lowScaleLineHigh: widget.lowScaleLineHigh,
          highScaleLineHigh: widget.highScaleLineHigh,
          initValue: widget.initValue,
          startValue: widget.startValue,
          endValue: widget.endValue,
          scaleValueSpace: widget.scaleValueSpace,
          space: widget.space,
          viewStyle: widget.viewStyle,
          textColor: widget.textColor,
          lowScaleLineColor: widget.lowScaleLineColor,
          middleScaleLineColor: widget.middleScaleLineColor,
          highScaleLineColor: widget.highScaleLineColor,
          lowScaleLineStrokeWidth: widget.lowScaleLineStrokeWidth,
          middleScaleLineStrokeWidth: widget.middleScaleLineStrokeWidth,
          highScaleLineStrokeWidth: widget.highScaleLineStrokeWidth,
          showHighScaleLine: widget.showHighScaleLine,
          showMiddleScaleLine: widget.showMiddleScaleLine,
          showLowScaleLine: widget.showLowScaleLine,
          showMiddleScaleNum: widget.showLowScaleLine,
          showHighScaleNum: widget.showHighScaleNum,
          showLowScaleNum: widget.showLowScaleNum,
          middleSpaceValueSpace: widget.middleSpaceValueSpace,
          highSpaceValeSpace: widget.highSpaceValeSpace,
          lineColor: widget.lineColor,
          lineStrokeWidth: widget.lineStrokeWidth,
          callback: widget.callback,
          showLine: widget.showLine,
        ),
      ),
      onPanDown: (DragDownDetails e) {
        _onTouchLocationX = e.globalPosition.dx;
      },
      onPanUpdate: (DragUpdateDetails e) {
        setState(() {
          _offsetX = e.globalPosition.dx - _onTouchLocationX + _lastMoveX;
        });
      },
      onPanEnd: (DragEndDetails e) {
        _lastMoveX = _offsetX;

        startAnimation();
      },
    );
  }

  double _offsetX = 0;
  double _lastMoveX = 0;
  double _onTouchLocationX = 0;
  late Animation<double> _animation;

  void startAnimation() {
    double offset;
    if (_offsetX > 0 && _offsetX > _leftXAxis.abs()) {
      //超出左边界的偏移
      offset = _offsetX - _leftXAxis.abs();
    } else if (_offsetX < 0 && _offsetX < -_rightXAxis) {
      //超出右边界的偏移
      offset = (_rightXAxis.abs() - _offsetX.abs());
    } else {
      //刻度尺内的偏移
      offset = calculateOffset();
    }
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: offset).animate(_controller)
      ..addListener(() {
        setState(() => {_offsetX = _lastMoveX - _controller.value * offset});
        debugPrint("startAnimation controller ${_controller.value}");
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _lastMoveX = _offsetX;
        }
      });
    //启动动画(正向执行)
    _controller.forward();
  }

  double calculateOffset() {
    debugPrint("calculateOffset _offsetX ${_offsetX}");
    debugPrint("calculateOffset  widget.space : ${widget.space}");

    if (widget.space > _offsetX.abs()) {
      debugPrint("calculateOffset  calculateOffset : ${_offsetX}");
      return _offsetX;
    }
    debugPrint("calculateOffset  calculateOffset : ${_offsetX % widget.space}");
    return _offsetX % widget.space;
  }
}

class RulerView extends CustomPainter {
  late Paint linePaint;
  late Paint lowScalePaint;
  late Paint middleScalePaint;
  late Paint highScalePaint;
  int startValue;
  int endValue;
  int initValue;
  double scaleValueSpace;
  double space;
  var lowScaleLineHigh;
  var middleScaleLineHigh;
  var highScaleLineHigh;
  ViewStyle viewStyle;
  double zoomTextSize = 0;
  double textSize = 0;
  double offset = 0;
  Color textColor;
  Color lowScaleLineColor;
  Color middleScaleLineColor;
  Color highScaleLineColor;
  double lowScaleLineStrokeWidth;
  double middleScaleLineStrokeWidth;
  double highScaleLineStrokeWidth;
  bool showLowScaleLine;
  bool showMiddleScaleLine;
  bool showHighScaleLine;
  bool showLowScaleNum;
  bool showMiddleScaleNum;
  bool showHighScaleNum;
  int middleSpaceValueSpace;
  int highSpaceValeSpace;
  bool showLine;
  double lineStrokeWidth;
  Color lineColor;
  ScaleValueChangeCallback callback;

  RulerView(
      {required this.offset,
      required this.textSize,
      required this.zoomTextSize,
      required this.middleScaleLineHigh,
      required this.highScaleLineHigh,
      required this.scaleValueSpace,
      required this.endValue,
      required this.startValue,
      required this.initValue,
      required this.space,
      required this.textColor,
      required this.viewStyle,
      required this.lowScaleLineHigh,
      required this.lowScaleLineColor,
      required this.middleScaleLineColor,
      required this.highScaleLineColor,
      required this.lowScaleLineStrokeWidth,
      required this.middleScaleLineStrokeWidth,
      required this.highScaleLineStrokeWidth,
      required this.showLowScaleLine,
      required this.showMiddleScaleLine,
      required this.showHighScaleLine,
      required this.showLowScaleNum,
      required this.showMiddleScaleNum,
      required this.middleSpaceValueSpace,
      required this.highSpaceValeSpace,
      required this.showHighScaleNum,
      required this.lineColor,
      required this.lineStrokeWidth,
      required this.callback,
      required this.showLine}) {
    linePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = this.lineColor
      ..strokeWidth = this.lineStrokeWidth;
    lowScalePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = this.lowScaleLineColor
      ..strokeWidth = this.lowScaleLineStrokeWidth;
    middleScalePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = this.middleScaleLineColor
      ..strokeWidth = this.middleScaleLineStrokeWidth;
    highScalePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = this.highScaleLineColor
      ..strokeWidth = this.highScaleLineStrokeWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawScale(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawCoordinateAxes(Canvas canvas, Size size) {
    canvas.save();
    canvas.drawLine(Offset(0, -size.height / 2), Offset(0, size.height / 2), linePaint);
    canvas.drawLine(Offset(-size.width / 2, 0), Offset(size.width / 2, 0), linePaint);
    canvas.restore();
  }

  void drawScale(Canvas canvas, Size size) {
    canvas.save();
    if (viewStyle.viewStyle == ViewStyle.valueDownScaleUpCloseStyle.viewStyle || viewStyle.viewStyle == ViewStyle.valueUpScaleDownCloseStyle.viewStyle) {
      canvas.translate(size.width / 2, size.height / 2);
    } else if (viewStyle.viewStyle == ViewStyle.valueDownScaleUpStyle.viewStyle || viewStyle.viewStyle == ViewStyle.valueUpScaleDownStyle.viewStyle) {
      canvas.translate(size.width / 2, 0);
    }
    //绘制坐标轴
    // drawCoordinateAxes(canvas, size);
    num currentXAxisCoordinate = 0 + offset;
    int currentValue = initValue;
    while (currentXAxisCoordinate >= -size.width / 2 && currentValue >= startValue) {
      drawScaleItem(canvas, currentXAxisCoordinate, currentValue, size);
      _drawTextPaintShowSize(canvas, currentXAxisCoordinate, currentValue, size);
      currentXAxisCoordinate = currentXAxisCoordinate - space;
      currentValue = currentValue - 1;
    }
    currentXAxisCoordinate = 0 + offset;
    currentValue = initValue;
    while (currentXAxisCoordinate <= size.width / 2 && currentValue <= endValue) {
      drawScaleItem(canvas, currentXAxisCoordinate, currentValue, size);
      _drawTextPaintShowSize(canvas, currentXAxisCoordinate, currentValue, size);
      currentXAxisCoordinate = currentXAxisCoordinate + space;
      currentValue = currentValue + 1;
    }
    canvas.restore();
  }

  void drawScaleItem(Canvas canvas, num currentXAxisCoordinate, int currentValue, Size size) {
    var offsetLowStart;
    var offsetLowEnd;
    var offsetMiddleStart;
    var offsetMiddleEnd;
    var offsetHighStart;
    var offsetHighEnd;
    var offsetLineStart;
    var offsetLineEnd;
    if (viewStyle.viewStyle == ViewStyle.valueDownScaleUpCloseStyle.viewStyle) {
      offsetLowStart = Offset(currentXAxisCoordinate.toDouble(), -scaleValueSpace / 2);
      offsetLowEnd = Offset(currentXAxisCoordinate.toDouble(), -lowScaleLineHigh - scaleValueSpace / 2);
      offsetMiddleStart = Offset(currentXAxisCoordinate.toDouble(), -scaleValueSpace / 2);
      offsetMiddleEnd = Offset(currentXAxisCoordinate.toDouble(), -middleScaleLineHigh - scaleValueSpace / 2);
      offsetHighStart = Offset(currentXAxisCoordinate.toDouble(), -scaleValueSpace / 2);
      offsetHighEnd = Offset(currentXAxisCoordinate.toDouble(), -highScaleLineHigh - scaleValueSpace / 2);
      offsetLineStart = Offset(-size.width / 2, -scaleValueSpace / 2);
      offsetLineEnd = Offset(size.width / 2, -scaleValueSpace / 2);
    } else if (viewStyle.viewStyle == ViewStyle.valueUpScaleDownCloseStyle.viewStyle) {
      offsetLowStart = Offset(currentXAxisCoordinate.toDouble(), scaleValueSpace / 2);
      offsetLowEnd = Offset(currentXAxisCoordinate.toDouble(), lowScaleLineHigh + scaleValueSpace / 2);
      offsetMiddleStart = Offset(currentXAxisCoordinate.toDouble(), scaleValueSpace / 2);
      offsetMiddleEnd = Offset(currentXAxisCoordinate.toDouble(), middleScaleLineHigh + scaleValueSpace / 2);
      offsetHighStart = Offset(currentXAxisCoordinate.toDouble(), scaleValueSpace / 2);
      offsetHighEnd = Offset(currentXAxisCoordinate.toDouble(), highScaleLineHigh + scaleValueSpace / 2);
      offsetLineStart = Offset(-size.width / 2, scaleValueSpace / 2);
      offsetLineEnd = Offset(size.width / 2, scaleValueSpace / 2);
    } else if (viewStyle.viewStyle == ViewStyle.valueDownScaleUpStyle.viewStyle) {
      offsetLowStart = Offset(currentXAxisCoordinate.toDouble(), lowScaleLineHigh.toDouble());
      offsetLowEnd = Offset(currentXAxisCoordinate.toDouble(), 0);
      offsetMiddleStart = Offset(currentXAxisCoordinate.toDouble(), middleScaleLineHigh.toDouble());
      offsetMiddleEnd = Offset(currentXAxisCoordinate.toDouble(), 0);
      offsetHighStart = Offset(currentXAxisCoordinate.toDouble(), highScaleLineHigh.toDouble());
      offsetHighEnd = Offset(currentXAxisCoordinate.toDouble(), 0);
      offsetLineStart = Offset(-size.width / 2, 0);
      offsetLineEnd = Offset(size.width / 2, 0);
    } else if (viewStyle.viewStyle == ViewStyle.valueUpScaleDownStyle.viewStyle) {
      offsetLowStart = Offset(currentXAxisCoordinate.toDouble(), size.height);
      offsetLowEnd = Offset(currentXAxisCoordinate.toDouble(), size.height - lowScaleLineHigh);
      offsetMiddleStart = Offset(currentXAxisCoordinate.toDouble(), size.height);
      offsetMiddleEnd = Offset(currentXAxisCoordinate.toDouble(), size.height - middleScaleLineHigh);
      offsetHighStart = Offset(currentXAxisCoordinate.toDouble(), size.height);
      offsetHighEnd = Offset(currentXAxisCoordinate.toDouble(), size.height - highScaleLineHigh);
      offsetLineStart = Offset(-size.width / 2, size.height);
      offsetLineEnd = Offset(size.width / 2, size.height);
    }
    if (showLine) {
      canvas.drawLine(offsetLineStart, offsetLineEnd, linePaint);
    }
    if (showLowScaleLine) {
      canvas.drawLine(offsetLowStart, offsetLowEnd, lowScalePaint);
    }
    if (currentValue % middleSpaceValueSpace == 0) {
      if (showMiddleScaleLine) {
        canvas.drawLine(offsetMiddleStart, offsetMiddleEnd, middleScalePaint);
      }
    }
    if (currentValue % highSpaceValeSpace == 0) {
      if (showHighScaleLine) {
        canvas.drawLine(offsetHighStart, offsetHighEnd, highScalePaint);
      }
    }
  }

  int callbackCache = -1;
  void _drawTextPaintShowSize(Canvas canvas, num currentXAxisCoordinate, int currentValue, Size canvasSize) {
    // if (currentXAxisCoordinate == 0 || currentXAxisCoordinate.abs() < space * 0.3) {
    if (currentXAxisCoordinate == 0){
    if (callback != null) {
        callbackCache = currentValue;
        callback.call(currentValue);
      }
    }
    double finalTextSize = textSize;
    if (currentXAxisCoordinate.abs() <= space) {
      if (currentXAxisCoordinate == 0) {
        finalTextSize = zoomTextSize;
      } else {
        finalTextSize = (((space - currentXAxisCoordinate.abs()) / space) * (zoomTextSize - textSize)) + textSize;
      }
    } else {
      finalTextSize = textSize;
    }
    TextPainter textPainter =
        TextPainter(text: TextSpan(text: '$currentValue', style: TextStyle(fontSize: finalTextSize, color: textColor)), textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    textPainter.layout(); // 进行布局
    Size size = textPainter.size; // 尺寸必须在布局后获取
    var offset;
    if (viewStyle.viewStyle == ViewStyle.valueDownScaleUpCloseStyle.viewStyle) {
      offset = Offset(currentXAxisCoordinate - size.width / 2, 0 + scaleValueSpace / 2);
    } else if (viewStyle.viewStyle == ViewStyle.valueUpScaleDownCloseStyle.viewStyle) {
      offset = Offset(currentXAxisCoordinate - size.width / 2, 0 - scaleValueSpace / 2 - size.height);
    } else if (viewStyle.viewStyle == ViewStyle.valueDownScaleUpStyle.viewStyle) {
      offset = Offset(currentXAxisCoordinate - size.width / 2, canvasSize.height - size.height);
    } else if (viewStyle.viewStyle == ViewStyle.valueUpScaleDownStyle.viewStyle) {
      offset = Offset(currentXAxisCoordinate - size.width / 2, 0);
    }
    if (((currentValue % middleSpaceValueSpace == 0 && showMiddleScaleNum) || (currentValue % highSpaceValeSpace == 0 && showHighScaleNum) || showLowScaleNum)) textPainter.paint(canvas, offset);
  }
}
