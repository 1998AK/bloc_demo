import 'package:flutter/cupertino.dart';

void spiralMatrix(){
  int column = 4;
  int number = 12;

  int row = (number / column).ceil();
  int left = 0,top = 0;
  int right = column - 1;
  int bottom = row - 1;
  int count = 1;

  List<List<int>> valueStore = List.generate(row, (_) => List.filled(column, 0));

  debugPrint("data is ${valueStore}");

  while(count <= number){

    // left to right
    for(int i = left; i <= right && count <= number ;i++){
      valueStore[top][i] = count++;
    }
    top++;

    // right to bottom
    for(int i = top ;   i <= bottom && count <= number ; i ++){
      valueStore[i][right] = count++;
    }
    right --;

    // right to left

    for(int i = right ; i >= left && count <= number ; i--){
      valueStore[bottom][i] = count++;
    }
    bottom --;

    debugPrint("data is 2 ${valueStore}");
    // bottom to top
    for(int i = bottom ; i>= top && count <= number ; i--){
      valueStore[i][left] = count++;
    }
    left++;
  }

  for(var j in valueStore){
    print(j.map((data) => data.toString().padLeft(2)).join(' '));
  }

}