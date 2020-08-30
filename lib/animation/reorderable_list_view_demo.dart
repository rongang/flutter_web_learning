import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReorderAbleListDemo extends StatefulWidget {
  @override
  _ReorderAbleListDemoState createState() => _ReorderAbleListDemoState();
}

class _ReorderAbleListDemoState extends State<ReorderAbleListDemo> {

  final items = List.generate(
    10,
        (index) => Container(
      key: ValueKey(index),
      margin: EdgeInsets.all(10),
      height: 200,
      width: 400,
      color: Colors.accents[index],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {
          print('$oldIndex -- $newIndex');
          var temp = items[oldIndex];
          if(oldIndex>newIndex){
            for(int i = oldIndex;i>newIndex;i--){
              items[i] = items[i-1];
            }
            items[newIndex] = temp;
          }
          else{
            for(int i = oldIndex;i<newIndex-1;i++){
              items[i] = items[i+1];
            }
            items[newIndex-1] = temp;
          }


        },
        children: items,
      ),
    );
  }
}
