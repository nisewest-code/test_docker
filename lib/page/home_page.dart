import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_docker/dialog/exit_bottomsheet_dialog.dart';
import 'package:test_docker/model/data.dart';
import 'package:test_docker/model/workout.dart';
import 'package:test_docker/util/dialog_util.dart';
import 'package:test_docker/widget/stopwatch_widget.dart';

import 'list_workout.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const StopWatchWidget(),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ListWorkout()),
                        );
                      },
                      child: Text(
                        'Workout Note',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )),
              ],
            )));
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await DialogUtil.showBottomSheet(
        context, const ExitBottomSheetDialog());
    return exitResult ?? false;
  }
}
