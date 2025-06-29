import 'dart:math';

import 'package:flutter/material.dart';

class BoxGame extends StatefulWidget {
  const BoxGame({super.key});

  @override
  State<BoxGame> createState() => _BoxGameState();
}

class _BoxGameState extends State<BoxGame> {

  final countController = TextEditingController();
  int? blueIndex;
  List<Color> boxColor = [];
  int itemCount = 0;

  void resetGame(){
    blueIndex = null;
    boxColor.clear();
    itemCount = 0;
    countController.clear();
    setState(() {});
  }

  void showGameOurDialog(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game over"),
        content: Text("All box are red! this game is over"),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
            resetGame();
          }, child: Text("ok"))
        ],
      ),
    );
  }

  void onSubmitFieldMethod(){

    debugPrint("call this funcation");
    setState(() {
      itemCount = int.tryParse(countController.text) ?? 0;
      if(itemCount > 0){
        boxColor = List.generate(itemCount, (_) => Colors.grey);
        showRandomNumber();
      }
    });
  }

  void showRandomNumber(){
    if(blueIndex != null && boxColor[blueIndex!] != Colors.red){
      boxColor[blueIndex!] = Colors.red;
    }

    if(boxColor.every((colors) => colors == Colors.red)){
      // "game our"
      showGameOurDialog();
      return;
    }

    List<int> showAvailableIndex = [];
    for(int i = 0 ; i < boxColor.length ; i++){
      if(boxColor[i] != Colors.red){
        showAvailableIndex.add(i);
      }
    }

    if(showAvailableIndex.isNotEmpty){
      int randomNO = Random().nextInt(showAvailableIndex.length);
      blueIndex = showAvailableIndex[randomNO];
      boxColor[blueIndex!] = Colors.blue;
    }

    setState(() {});
  }

  void onTapBlueBox(int index){
    if(boxColor[index] == Colors.blue){
      showRandomNumber();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Box game"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: countController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (val) => onSubmitFieldMethod(),
              ),

              GridView.builder(
                shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8
                  ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => onTapBlueBox(index),
                    child: Container(
                      color: boxColor[index],
                      child: Center(child: Text("$index")),
                    ),
                  );
                },
                itemCount: itemCount,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
