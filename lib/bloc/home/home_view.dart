import 'package:bloc_demo/localdatabase/local_database.dart';
import 'package:bloc_demo/utils/common_text_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: InkWell(onTap: () async{
      await addNewDataInLocal(newCheckData: {"Name": "alpesh kukadiya"});
    },child: CommonTextWidget(text: "Home"))),);
  }
}
