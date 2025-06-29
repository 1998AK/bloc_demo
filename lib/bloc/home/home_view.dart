import 'dart:math';

import 'package:bloc_demo/localdatabase/local_database.dart';
import 'package:bloc_demo/utils/common_text_widget.dart';
import 'package:bloc_demo/utils/screen_width_dynamic.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Center(child: Column(
        children: [
          InkWell(onTap: () async{
            await addNewDataInLocal(newCheckData: {"Name": "Sunder Raj ${Random().nextInt(10)}"});
          },child: CommonTextWidget(text: "Home")),

          addVerticalSpace(height: 10),

          InkWell(onTap: () async{
            await updateCheckDetails(tableId: "1",updatedData: {"Name": "Donall Trump"});
            showTableData(tableName: Attendance.attendanceTable);
          },child: CommonTextWidget(text: "update")),

          addVerticalSpace(height: 10),

          InkWell(onTap: () async{
            await deleteCheckInImage(tableId: "1");
            showTableData(tableName: Attendance.attendanceTable);
          },child: CommonTextWidget(text: "delete data")),
        ],
      )),),
    );
  }
}
