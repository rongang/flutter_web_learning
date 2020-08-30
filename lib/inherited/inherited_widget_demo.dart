import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountInherited extends InheritedWidget {
  final MyNotifier count;
  final Widget child;

  CountInherited({this.count, this.child});

  @override
  bool updateShouldNotify(CountInherited oldWidget) {
    return oldWidget.count.value != count.value;
  }
}

class MyNotifier extends ValueNotifier<int> {
  MyNotifier({int count = 1}) : super(count);
}

class InheritedDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CountInherited(
      count: MyNotifier(count: 10),
      child: Scaffold(
          body: Builder(
              builder: (context) {
                CountInherited countInherited =
                context.dependOnInheritedWidgetOfExactType<
                    CountInherited>();
                return ValueListenableBuilder(
                  valueListenable: countInherited.count,
                  builder: (context, value, child) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                              color: Colors.red,
                              child: Text(
                                '+',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline1.copyWith(height: 0.7),
                              ),
                            ),
                            onTap: () {
                              countInherited.count.value++;
                            },
                          ),
                          RaisedButton(
                            child: Text(
                              value.toString(),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline3,
                            ),
                            onPressed: null,
                          ),
                          RaisedButton(
                            child: Text(
                              '-',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline3,
                            ),
                            onPressed: () {
                              countInherited.count.value--;
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              }
          )
      ),
    );
  }
}
