import 'package:ffloat/ffloat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_learning/animation/animated_icon_demo.dart';
import 'package:flutter_web_learning/animation/reorderable_list_view_demo.dart';
import 'package:flutter_web_learning/chart_page.dart';
// import 'package:flutter_web_learning/html_test.dart';
import 'package:flutter_web_learning/inherited/inherited_widget_demo.dart';
import 'package:flutter_web_learning/url_launching_demo.dart';
// import 'package:universal_html/js.dart' as js;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ReorderAbleListDemo()//InheritedDemo()//FFloatPage() //MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class FFloatPage extends StatefulWidget {
  @override
  _FFloatPageState createState() => _FFloatPageState();
}

class _FFloatPageState extends State<FFloatPage> {
  final FFloatController controller = FFloatController();

  GlobalKey chartKey = GlobalKey();
  Offset offset;
  OverlayEntry overlayEntry;
  RenderBox renderBox;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width*0.8;
    print('FFloatPage build');
    return  Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              key: chartKey,
              width: width,
              height: 500,
              child: PointsLineChart.withSampleData()..nowSate = (int index,int height){
                renderBox = chartKey.currentContext.findRenderObject();
                offset = renderBox.localToGlobal(Offset.zero);
                handlePop(context, height*1.0, offset.dx+(width/11)*index);
              },
            ),
            FFloat(
                (_) => Text('hello'),
              alignment: FFloatAlignment.topLeft,
              anchor: Text('hello'),
            ),
          ],
        ),
      ),
    );
  }

  void handlePop(BuildContext context, double dy, double dx) {
    print('$dx--$dy');
    OverlayState overlayState = Overlay.of(context);
    if(overlayEntry!=null) overlayEntry?.remove();
    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Stack(
        children: [
          Positioned(
            child: Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              color: Colors.red,
            ),
            top: offset.dx+500-dy*10,
            left: dx,
          ),
        ],
      );
    });

    overlayState.insert(overlayEntry);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // htmlTest();

    // print('${js.context.toString()}');
    // print('${js.context['location']}');
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
