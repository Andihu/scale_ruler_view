import 'package:flutter/material.dart';
import 'package:scale_ruler_view/scale_ruler_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Center(
              child: Container(
                color: Colors.black87,
                child:
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
                  callback:(int value){
                    debugPrint("scaleValueChange  ${value}");
                  },
                ),
              )
          ),
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
