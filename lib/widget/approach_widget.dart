import 'package:flutter/material.dart';
import 'package:test_docker/model/exercise.dart';
import 'package:test_docker/page/approach_page.dart';

import '../model/approach.dart';
import 'package:collection/collection.dart';

class ApproachWidget extends StatefulWidget {
  const ApproachWidget({Key? key, required this.listExercise})
      : super(key: key);
  final List<ApproachWeight> listExercise;

  @override
  State<ApproachWidget> createState() => _ApproachWidgetState();
}

class _ApproachWidgetState extends State<ApproachWidget> {
  late List<ApproachWeight> _list;

  @override
  void initState() {
    super.initState();
    _list = widget.listExercise;
  }

  @override
  Widget build(BuildContext context) {
    var sumKg = _list.map((e) => (e).weight).toList().sum;
    var sumRepeat = _list.map((e) => e.countRepeat).toList().sum;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      if (_list.isNotEmpty) Text("$sumKg kg x $sumRepeat, ${_list.length} approach"),
      Row(
        children: [
          Container(
              width: 100,
              child: Column(
                children: _list.map((e) {
                  var val = e;
                  return Text("${val.weight} kg. X ${val.countRepeat}");
                }).toList(),
              )),
          FloatingActionButton.small(
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
            child: Icon(Icons.add),
          )
        ],
      )
    ]);
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    ApproachWeight? result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ApproachPage(
          )),
    ) as ApproachWeight?;
    if (!mounted) return;
    if (result != null){
      setState(() {
        _list.add(result);
      });
    }
  }
}
